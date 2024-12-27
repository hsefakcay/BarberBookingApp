import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/sizes.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/models/service.dart';
import 'package:barber_booking_app/product/widgets/back_button_widget.dart';
import 'package:barber_booking_app/product/widgets/bottom_bar_button_widget.dart';
import 'package:barber_booking_app/product/widgets/save_button.dart';
import 'package:barber_booking_app/product/services/service_service.dart';
import 'package:barber_booking_app/feature/barber_detail_page/widgets/bottom_sheet_widget.dart';
import 'package:barber_booking_app/feature/barber_detail_page/widgets/pro_barber_label.dart';
import 'package:flutter/material.dart';

class BarberDetailPage extends StatefulWidget {
  const BarberDetailPage({super.key, required this.barber});
  final Barber barber;

  @override
  State<BarberDetailPage> createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage> {
  final ServiceService _serviceService = ServiceService();
  late Future<List<Service>> _services;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _services = _serviceService.fetchServices();
  }

  final String bottomButtonText = "BOOK NOW";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarButton(
          text: bottomButtonText, backgroundColor: ColorConstants.yellowColor, onPressed: () {}),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Positioned.fill(child: _barberImage(context)),
          const Positioned(top: 30, left: 20, child: CustomBackButton()),
          const Positioned(top: 30, right: 20, child: SaveButton()),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.3,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                color: ColorConstants.blackColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProBarberLabel(),
                        _buildBarberName(context),
                        BuildBarberRatings(barber: widget.barber)
                      ],
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                    Column(
                      children: [
                        _bookingDateCard(context),
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                        serviceOptionsList(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container serviceOptionsList(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.38, // Container boyutunu sabit tutuyoruz
      decoration: BoxDecoration(
        color: ColorConstants.darkGreyColor,
        border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: FutureBuilder(
          future: _services,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No barbers found'));
            }
            final services = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Column(
                  children: [
                    SwitchListTile(
                      title: Text(service.name, style: Theme.of(context).textTheme.bodyLarge),
                      subtitle: Row(
                        children: [
                          Text(
                            '\$ ${service.price}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            ' - ${service.duration} min',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      value: true, // Her öğe için durum
                      activeColor: Colors.yellow,
                      onChanged: (newValue) {
                        setState(() {
                          // service.isSelected = newValue; // Durum güncelleniyor
                        });
                      },
                    ),
                    const Divider(color: ColorConstants.greyColor, indent: 10, endIndent: 10),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Container _bookingDateCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.darkGreyColor,
        border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_dateAndTime(context), editButton(context)],
        ),
      ),
    );
  }

  IconButton editButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        bottomSheet(context);
      },
      icon: const Icon(Icons.edit_outlined, size: IconSizes.largeIcon),
    );
  }

  Column _dateAndTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FRIDAY, AUGUST 25',
          style:
              Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorConstants.yellowColor),
        ),
        Text('15:00-16:00', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Text _buildBarberName(BuildContext context) {
    return Text(widget.barber.name, style: Theme.of(context).textTheme.headlineSmall);
  }

  SizedBox _barberImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
      child: Image.network(
        alignment: Alignment.topCenter,
        widget.barber.photo,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class BuildBarberRatings extends StatelessWidget {
  const BuildBarberRatings({
    required this.barber,
    super.key,
  });

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_sharp, size: IconSizes.mediumIcon, color: ColorConstants.yellowColor),
        Text(barber.ratings.toString(), style: Theme.of(context).textTheme.bodyMedium),
        Text(' - ${barber.reviews} reviews', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
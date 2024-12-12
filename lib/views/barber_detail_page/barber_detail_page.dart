import 'package:barber_booking_app/core/constants/colors.dart';
import 'package:barber_booking_app/core/constants/sizes.dart';
import 'package:barber_booking_app/model/barber_model.dart';
import 'package:barber_booking_app/model/service_model.dart';
import 'package:barber_booking_app/product/widgets/back_button_widget.dart';
import 'package:barber_booking_app/product/widgets/bottom_bar_button_widget.dart';
import 'package:barber_booking_app/product/widgets/save_button.dart';
import 'package:barber_booking_app/views/barber_detail_page/widgets/bottom_sheet_widget.dart';
import 'package:barber_booking_app/views/barber_detail_page/widgets/pro_barber_label.dart';
import 'package:flutter/material.dart';

class BarberDetailPage extends StatefulWidget {
  const BarberDetailPage({super.key, required this.barber});
  final Barber barber;

  @override
  State<BarberDetailPage> createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage> {
  List<Service> services = [
    Service(name: "HAIRCUT", price: "\$20.99", duration: 40),
    Service(name: "KIDS CUT", price: "\$15.99", duration: 30),
    Service(name: "BEARD CUT", price: "\$15.99", duration: 20),
    Service(name: "BUZZ CUT", price: "\$18.99", duration: 30),
    Service(name: "HAIR COLOR", price: "\$25.99", duration: 50),
  ];
  final String bottomButtonText = "BOOK NOW";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomBarButton(text: bottomButtonText, backgroundColor: yellowColor, onPressed: () {}),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Positioned(child: _barberImage(context)),
          const Positioned(top: 30, left: 20, child: CustomBackButton()),
          const Positioned(top: 30, right: 20, child: SaveButton()),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.3,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40), topRight: Radius.circular(40))),
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
              )),
        ],
      ),
    );
  }

  Container serviceOptionsList(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.28,
      decoration: BoxDecoration(
          color: darkGreyColor,
          border: Border.all(color: borderDarkColor, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: services.length,
            itemBuilder: (context, index) {
              var service = services[index];
              return Column(
                children: [
                  SwitchListTile(
                    title: Text(service.name, style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Row(
                      children: [
                        Text("${service.price} ", style: Theme.of(context).textTheme.bodyMedium),
                        Text("- ${service.duration} min",
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                    value: service.isSelected, // Her öğe için durum
                    activeColor: Colors.yellow,
                    onChanged: (newValue) {
                      setState(() {
                        service.isSelected = newValue; // Durum güncelleniyor
                      });
                    },
                  ),
                  Divider(color: greyColor, indent: 10, endIndent: 10),
                ],
              );
            }),
      ),
    );
  }

  Container _bookingDateCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: darkGreyColor,
          border: Border.all(color: borderDarkColor, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
        icon: const Icon(Icons.edit_outlined, size: IconSizes.largeIcon));
  }

  Column _dateAndTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FRIDAY, AUGUST 25",
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: yellowColor),
        ),
        Text("15:00-16:00", style: Theme.of(context).textTheme.bodyLarge)
      ],
    );
  }

  Text _buildBarberName(BuildContext context) {
    return Text(widget.barber.name, style: Theme.of(context).textTheme.headlineSmall);
  }

  SizedBox _barberImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Image.asset(
        alignment: Alignment.topCenter,
        "assets/images/${widget.barber.photo}",
        fit: BoxFit.contain,
      ),
    );
  }
}

class BuildBarberRatings extends StatelessWidget {
  const BuildBarberRatings({
    super.key,
    required this.barber,
  });

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.star_sharp, size: IconSizes.mediumIcon, color: yellowColor),
      Text(barber.ratings.toString(), style: Theme.of(context).textTheme.bodyMedium),
      Text(" - ${barber.reviews} reviews", style: Theme.of(context).textTheme.bodySmall)
    ]);
  }
}

import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/models/barbershop.dart';
import 'package:barber_booking_app/product/services/barber_service.dart';
import 'package:barber_booking_app/product/services/barber_shop_service.dart';
import 'package:barber_booking_app/product/widgets/barber_card_widget.dart';
import 'package:barber_booking_app/product/widgets/barbershop_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BarberService _barberService = BarberService();
  final BarberShopService _barberShopService = BarberShopService();
  late Future<List<Barber>> _barbers;
  late Future<List<BarberShop>> _barberShops;
  @override
  void initState() {
    super.initState();
    _barbers = _barberService.fetchBarbers();
    _barberShops = _barberShopService.fetchBarberShops();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: height * 0.05,
        title: Text(
          appLocalizations?.date ?? '',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.notifications, color: ColorConstants.greyColor, size: height * 0.04),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: ColorConstants.greyColor, size: height * 0.04),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _helloTextRow(appLocalizations, context),
              SizedBox(height: height * 0.03),
              _textField(appLocalizations),
              SizedBox(height: height * 0.03),
              _latestVisitRow(height, appLocalizations, context),
              SizedBox(height: height * 0.03),
              _nearbyBarbershops(height, width, appLocalizations, context),
            ],
          ),
        ),
      ),
    );
  }

  Row _helloTextRow(AppLocalizations? appLocalizations, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${appLocalizations?.welcomeMessage ?? ""},",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          FirebaseAuth.instance.currentUser?.refreshToken ?? '',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Column _nearbyBarbershops(
    double height,
    double width,
    AppLocalizations? appLocalizations,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            appLocalizations?.nearbyBarbershops ?? '',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        SizedBox(
          height: height * 0.47,
          child: FutureBuilder(
            future: _barberShops,
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
              final barberShops = snapshot.data!;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: barberShops.length,
                itemBuilder: (context, index) {
                  final barberShop = barberShops[index];
                  return SizedBox(
                    width: width * 0.6,
                    child: BarberShopCard(barberShop: barberShop),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column _latestVisitRow(double height, AppLocalizations? appLocalizations, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            appLocalizations?.latestVisit ?? '',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        _barberListView(height),
      ],
    );
  }

  TextField _textField(AppLocalizations? appLocalizations) {
    return TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstants.darkGreyColor,
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: ColorConstants.yellowColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: appLocalizations?.search ?? '',
        hintStyle: const TextStyle(
          color: ColorConstants.greyColor,
        ),
      ),
    );
  }

  SizedBox _barberListView(double height) {
    return SizedBox(
        height: height * 0.12,
        child: FutureBuilder(
          future: _barbers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Error: ${snapshot.error.toString().split(":").last.trim()}',
                textAlign: TextAlign.center,
              ),);
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No barbers found'));
            }
            final barbers = snapshot.data!;

            return ListView.builder(
              itemCount: barbers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final barber = barbers[index];
                return BarberCard(barber: barber);
              },
            );
          },
        ),);
  }
}

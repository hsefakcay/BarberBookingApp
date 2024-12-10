// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barber_booking_app/product/widgets/barber_card_widget.dart';
import 'package:barber_booking_app/product/widgets/barbershop_card_widget.dart';
import 'package:barber_booking_app/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:barber_booking_app/model/barber_model.dart';
import 'package:barber_booking_app/core/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    AppLocalizations? appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: height * 0.05,
          title: Text(
            appLocalizations?.date ?? "",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          leading: IconButton(
            icon: Icon(Icons.notifications, color: greyColor, size: height * 0.04),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: greyColor, size: height * 0.04),
              onPressed: () {},
            ),
          ]),
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
              _nearbyBarbershops(height, appLocalizations, context),
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
        Text("${appLocalizations?.welcomeMessage ?? ""},",
            style: Theme.of(context).textTheme.headlineLarge),
        Text("MICHAEL", style: Theme.of(context).textTheme.headlineLarge)
      ],
    );
  }

  Column _nearbyBarbershops(
      double height, AppLocalizations? appLocalizations, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(appLocalizations?.nearbyBarbershops ?? "",
              style: Theme.of(context).textTheme.labelMedium),
        ),
        Container(
          height: height * 0.47,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            BarberShopCard(
              barberShop: BarberShop(
                  name: "THE FADE FACTORY", distance: 0.7, ratings: 4.8, image: 'barberShop.jpg'),
            ),
            BarberShopCard(
                barberShop: BarberShop(
                    name: "CLEAN CUT CO.",
                    distance: 2.9,
                    ratings: 4.9,
                    image: 'barberShopBlack.jpg')),
            BarberShopCard(
                barberShop: BarberShop(
                    name: "CLEAN CUT CO.", distance: 0.7, ratings: 4.9, image: 'barberShop.jpg')),
            BarberShopCard(
                barberShop: BarberShop(
                    name: "THE FADE FACTORY",
                    distance: 0.7,
                    ratings: 4.8,
                    image: 'barberShopBlack.jpg')),
          ]),
        )
      ],
    );
  }

  Column _latestVisitRow(double height, AppLocalizations? appLocalizations, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            appLocalizations?.latestVisit ?? "",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        _barberListView(height)
      ],
    );
  }

  TextField _textField(AppLocalizations? appLocalizations) {
    return TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          filled: true,
          fillColor: darkGreyColor,
          prefixIcon: Icon(Icons.search),
          prefixIconColor: yellowColor,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: darkGreyColor),
              borderRadius: BorderRadius.circular(20)),
          hintText: appLocalizations?.search ?? "",
          hintStyle: TextStyle(color: greyColor, fontFamily: "Ubuntu")),
    );
  }

  SizedBox _barberListView(double height) {
    return SizedBox(
      height: height * 0.12,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          BarberCard(
              barber: Barber(
            name: "RICHARD ANDERSON",
            photo: "barberPhoto.jpg",
            ratings: 4.9,
            reviews: 114,
          )),
          BarberCard(
              barber: Barber(
            name: "MAX CUTTER",
            photo: "barberMax.jpg",
            ratings: 4.9,
            reviews: 114,
          )),
          BarberCard(
              barber: Barber(
            name: "RICHARD ANDERSON",
            photo: "barberPhoto.jpg",
            ratings: 4.9,
            reviews: 114,
          )),
          BarberCard(
              barber: Barber(
            name: "RICHARD ANDERSON",
            photo: "barberMax.jpg",
            ratings: 4.9,
            reviews: 114,
          )),
        ],
      ),
    );
  }
}

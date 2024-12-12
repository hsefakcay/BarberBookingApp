// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:barber_booking_app/model/barbershop_model.dart';
import 'package:barber_booking_app/core/constants/colors.dart';

class BarberShopCard extends StatelessWidget {
  const BarberShopCard({
    super.key,
    required this.barberShop,
  });

  final BarberShop barberShop;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    AppLocalizations? appLocalizations = AppLocalizations.of(context);

    return Card(
      color: darkGreyColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _barbershopImage(height, width, context),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(appLocalizations?.openNow ?? "",
                      style: TextStyle(color: yellowColor, fontFamily: "Ubuntu", fontSize: 10)),
                  Text(barberShop.name,
                      style: TextStyle(color: whiteColor, fontFamily: "Ubuntu", fontSize: 16)),
                  Row(
                    children: [
                      Icon(
                        Icons.navigation,
                        color: yellowColor,
                        size: 16,
                      ),
                      Text("${barberShop.distance.toString()} km",
                          style: TextStyle(color: whiteColor, fontFamily: "Ubuntu", fontSize: 12))
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _saveIconButton(context),
                const SizedBox(width: 10),
                _bookNowButton(appLocalizations, context, width),
              ],
            )
          ],
        ),
      ),
    );
  }

  Stack _barbershopImage(double height, double width, BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: greyColor), borderRadius: BorderRadius.circular(10)),
        height: height * 0.26,
        width: width * 0.5,
        child: Image.asset(
          "assets/images/${barberShop.image}",
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: 10,
        left: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: darkGreyColor,
          ),
          width: width * 0.15,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.star_sharp,
                  color: yellowColor,
                  size: width * 0.05,
                ),
                Text(
                  barberShop.ratings.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Container _bookNowButton(AppLocalizations? appLocalizations, BuildContext context, double width) {
    return Container(
      width: width * 0.35,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: yellowColor),
      child: TextButton(
        onPressed: () {
          //sayfa A e gitme işlemi
        },
        child: Text(appLocalizations?.bookNow ?? "", style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }

  Container _saveIconButton(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: greyButtonColor),
      child: IconButton(
        iconSize: 24,
        onPressed: () {
          //sayfa X e gitme işlemi
        },
        icon: const Icon(Icons.save),
        color: whiteColor,
      ),
    );
  }
}

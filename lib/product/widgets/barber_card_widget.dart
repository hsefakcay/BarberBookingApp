import 'package:barber_booking_app/model/barber_model.dart';
import 'package:barber_booking_app/core/constants/colors.dart';
import 'package:barber_booking_app/views/barber_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BarberCard extends StatelessWidget {
  const BarberCard({
    super.key,
    required this.barber,
  });

  final Barber barber;
  @override
  Widget build(BuildContext context) {
    final double weight = MediaQuery.sizeOf(context).width;
    AppLocalizations? appLocalizations = AppLocalizations.of(context);

    return SizedBox(
      height: 100,
      width: weight * 0.85,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarberDetailPage(barber: barber),
              ));
        },
        child: Card(
          color: darkGreyColor,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: greyColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "assets/images/${barber.photo}",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(barber.name, style: Theme.of(context).textTheme.bodyLarge),
                  Row(
                    children: [
                      Icon(Icons.star_sharp, color: yellowColor),
                      Text(barber.ratings.toString(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text("- ${barber.reviews} ${appLocalizations?.reviews}",
                          style: Theme.of(context).textTheme.bodySmall)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

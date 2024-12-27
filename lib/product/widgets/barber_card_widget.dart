import 'package:barber_booking_app/feature/barber_detail_page/barber_detail_page_view.dart';
import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BarberCard extends StatelessWidget {
  const BarberCard({
    required this.barber,
    super.key,
  });

  final Barber barber;
  @override
  Widget build(BuildContext context) {
    final weight = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context);

    return SizedBox(
      height: height * 0.1,
      width: weight * 0.8,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (context) => BarberDetailPage(barber: barber),
            ),
          );
        },
        child: Card(
          color: ColorConstants.darkGreyColor,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: ColorConstants.greyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    barber.photo,
                    width: height * 0.09,
                    height: height * 0.09,
                    fit: BoxFit.cover,
                    loadingBuilder:
                        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/defaultBarber.jpg',
                        fit: BoxFit.cover,
                      );
                    },
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
                      const Icon(Icons.star_sharp, color: ColorConstants.yellowColor),
                      Text(
                        barber.ratings.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '- ${barber.reviews} ${appLocalizations?.reviews}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

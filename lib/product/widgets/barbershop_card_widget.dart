import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/enums/icon_size.dart';
import 'package:barber_booking_app/product/models/barbershop.dart';
import 'package:barber_booking_app/product/utility/app_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kartal/kartal.dart';

class BarberShopCard extends StatelessWidget {
  const BarberShopCard({
    required this.barberShop,
    super.key,
  });

  final BarberShop barberShop;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context);

    return Card(
      color: ColorConstants.darkGreyColor,
      shape: AppShapes.cardShape,
      child: Padding(
        padding: const EdgeInsets.all(8),
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
                  Text(
                    appLocalizations?.openNow ?? '',
                    style: const TextStyle(
                      color: ColorConstants.yellowColor,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    barberShop.name,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ColorConstants.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    // TO DO: will add theme textStyle
                    children: [
                      const Icon(
                        Icons.navigation,
                        color: ColorConstants.yellowColor,
                        size: 16,
                      ),
                      Text(
                        '${barberShop.distance} km',
                        style: const TextStyle(
                          color: ColorConstants.whiteColor,
                          fontSize: 12,
                        ),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }

  Stack _barbershopImage(double height, double width, BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.greyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          height: height * 0.26,
          width: width * 0.55,
          child: Image.network(
            barberShop.image,
            fit: BoxFit.cover,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
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
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) {
              // TO DO: url const
              return Image.asset(
                'assets/images/barberShop.jpg',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.darkGreyColor,
            ),
            width: width * 0.15,
            child: Padding(
              padding: context.padding.low,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.star_sharp,
                    color: ColorConstants.yellowColor,
                    size: IconSize.small.value,
                  ),
                  Text(
                    barberShop.ratings.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _bookNowButton(
    AppLocalizations? appLocalizations,
    BuildContext context,
    double width,
  ) {
    return Container(
      width: width * 0.39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.yellowColor,
      ),
      child: TextButton(
        onPressed: () {
          //sayfa A e gitme işlemi
        },
        child: Text(
          appLocalizations?.bookNow ?? '',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: ColorConstants.blackColor,
              ),
        ),
      ),
    );
  }

  Container _saveIconButton(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.greyButtonColor,
      ),
      child: IconButton(
        iconSize: IconSize.normal.value,
        onPressed: () {
          //sayfa X e gitme işlemi
        },
        icon: const Icon(Icons.bookmark_border_rounded),
        color: ColorConstants.whiteColor,
      ),
    );
  }
}

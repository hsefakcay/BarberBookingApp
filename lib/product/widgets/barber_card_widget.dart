import 'package:barber_booking_app/feature/barber_detail_page/barber_detail_page_view.dart';
import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/enums/icon_size.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/utility/app_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kartal/kartal.dart';

class BarberCard extends StatelessWidget {
  const BarberCard({
    required this.barber,
    super.key,
  });

  final Barber barber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.general.mediaSize.height * 0.1,
      width: context.general.mediaSize.width * 0.8,
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
          shape: AppShapes.cardShape,
          child: Row(
            children: [
              _barberImage(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _barberName(context),
                  _barberReviewRow(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _barberReviewRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_sharp,
          color: ColorConstants.yellowColor,
          size: IconSize.small.value,
        ),
        Text(
          barber.ratings.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '- ${barber.reviews} ${AppLocalizations.of(context)?.reviews}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorConstants.greyColor,
              ),
        ),
      ],
    );
  }

  Text _barberName(BuildContext context) =>
      Text(barber.name, style: Theme.of(context).textTheme.bodyLarge);

  Padding _barberImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.greyColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.network(
          barber.photo,
          width: context.general.mediaSize.height * 0.09,
          height: context.general.mediaSize.height * 0.09,
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
            return Image.asset(
              // TO DO : update this url
              'assets/images/defaultBarber.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

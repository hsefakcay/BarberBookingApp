import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ProBarberLabel extends StatelessWidget {
  const ProBarberLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: ColorConstants.yellowColor, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Text('PRO BARBER',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorConstants.blackColor, fontWeight: FontWeight.w900),),
        ),);
  }
}

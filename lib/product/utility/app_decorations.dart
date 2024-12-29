import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  // Standard border decoration
  static BoxDecoration standardBorderDecoration({Color? color, double? radius}) {
    return BoxDecoration(
      border: Border.all(color: color ?? ColorConstants.greyColor),
      borderRadius: BorderRadius.circular(radius ?? 15),
    );
  }
}

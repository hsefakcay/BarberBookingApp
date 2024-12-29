import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppShapes {
  static RoundedRectangleBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15), // Köşe yuvarlaması
    side: const BorderSide(
      width: 0.8,
      color: ColorConstants.greyColor, // Kenarlık rengi
    ),
  );
}

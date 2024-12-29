import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/enums/icon_size.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorConstants.blackColor,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: ColorConstants.whiteColor,
          size: IconSize.normal.value,
        ),
      ),
    );
  }
}

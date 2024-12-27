import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorConstants.blackColor,
      child: InkWell(
        onTap: () {},
        child: Image.asset(
          height: 20,
          'assets/icons/save_icon.png',
          color: ColorConstants.whiteColor,
        ),
      ),
    );
  }
}

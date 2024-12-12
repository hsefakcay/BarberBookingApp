import 'package:barber_booking_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: blackColor,
      child: InkWell(
        onTap: () {},
        child: Image.asset(
          height: 20,
          "assets/icons/save_icon.png",
          color: whiteColor,
        ),
      ),
    );
  }
}

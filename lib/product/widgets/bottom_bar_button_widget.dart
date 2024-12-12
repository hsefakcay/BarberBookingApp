// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:barber_booking_app/core/constants/colors.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final Color backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: darkGreyColor,
          border: Border.all(color: borderDarkColor, width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: blackColor, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}

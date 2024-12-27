import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({required this.text, required this.onPressed, super.key});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.general.mediaSize.width,
      decoration: BoxDecoration(
          color: ColorConstants.darkGreyColor,
          border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
          borderRadius: BorderRadius.circular(30),),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.yellowColor),
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorConstants.blackColor, fontWeight: FontWeight.bold),
            ),),
      ),
    );
  }
}
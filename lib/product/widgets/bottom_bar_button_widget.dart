import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    required this.text,
    required this.backgroundColor,
    super.key,
    this.onPressed,
  });
  final String text;
  final Color backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.darkGreyColor,
        border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: ColorConstants.blackColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

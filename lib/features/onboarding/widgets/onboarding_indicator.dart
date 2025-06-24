import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {

  const OnboardingIndicator({required this.currentIndex, super.key});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: currentIndex == index ? 15 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == index ? ColorConstants.yellowColor : ColorConstants.greyColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: ColorConstants.borderDarkColor, width: 0.5),
          ),
        );
      }),
    );
  }
}

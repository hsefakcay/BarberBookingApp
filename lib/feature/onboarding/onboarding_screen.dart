import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/barber_onboarding2.jpg', fit: BoxFit.cover),
        ),
        Positioned(
          top: context.general.mediaSize.height * 0.68,
          left: 20,
          right: 20,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

import 'package:barber_booking_app/feature/onboarding/onboarding_screen.dart';
import 'package:barber_booking_app/feature/onboarding/widgets/onboarding_button.dart';
import 'package:barber_booking_app/feature/onboarding/widgets/onboarding_indicator.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:flutter/material.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  OnboardingPageViewState createState() => OnboardingPageViewState();
}

class OnboardingPageViewState extends State<OnboardingPageView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: const [
              OnboardingScreen(title: StringConstants.onBoardingTitle1),
              OnboardingScreen(title: StringConstants.onBoardingTitle2),
              OnboardingScreen(title: StringConstants.onBoardingTitle3),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                OnboardingIndicator(currentIndex: _currentIndex),
                const SizedBox(height: 20),
                OnboardingButton(
                  text: _currentIndex == 2 ? 'Get Started' : 'Next',
                  onPressed: () {
                    if (_currentIndex < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Navigate to Login or SignUp Screen
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:barber_booking_app/feature/auth/authentication_view.dart';
import 'package:barber_booking_app/feature/home_page/home_page_view.dart';
import 'package:barber_booking_app/feature/onboarding/onboarding_page_view.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static Map<String, StatefulWidget Function(dynamic context)> routes = {
    '/onboarding': (context) => const OnboardingPageView(),
    '/login': (context) => const AuthenticationView(),
    '/home': (context) => const HomePage(),
  };
}

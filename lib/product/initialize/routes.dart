import 'package:barber_booking_app/feature/appointments_page/appointments_page.dart';
import 'package:barber_booking_app/feature/auth/authentication_view.dart';
import 'package:barber_booking_app/feature/complete_profile_page/complete_profile_page_view.dart';
import 'package:barber_booking_app/feature/favorites_page/favorites_page_view.dart';
import 'package:barber_booking_app/feature/home_page/home_view.dart';
import 'package:barber_booking_app/feature/onboarding/onboarding_page_view.dart';
import 'package:barber_booking_app/feature/profile_page/profil_page_view.dart';
import 'package:barber_booking_app/feature/settings_page/settings_page_view.dart';
import 'package:barber_booking_app/feature/splash/splash_view.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static Map<String, StatefulWidget Function(dynamic context)> routes = {
    '/splash': (context) => const SplashView(),
    '/onboarding': (context) => const OnboardingPageView(),
    '/login': (context) => const AuthenticationView(),
    '/home': (context) => const HomeView(),
    '/profile': (context) => const ProfilePage(),
    '/favorites': (context) => const FavoritesPage(),
    '/setting': (context) => const SettingsPage(),
    '/completeProfile': (context) => const CompleteProfilePage(),
    '/appointments': (context) => const AppointmentsPage(),
  };
}

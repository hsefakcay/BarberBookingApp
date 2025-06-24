import 'package:barber_booking_app/features/appointments_page/appointments_page.dart';
import 'package:barber_booking_app/features/auth/authentication_view.dart';
import 'package:barber_booking_app/features/complete_profile_page/complete_profile_page_view.dart';
import 'package:barber_booking_app/features/favorites_page/favorites_page_view.dart';
import 'package:barber_booking_app/features/home_page/home_view.dart';
import 'package:barber_booking_app/features/onboarding/onboarding_page_view.dart';
import 'package:barber_booking_app/features/profile_page/profil_page_view.dart';
import 'package:barber_booking_app/features/settings_page/settings_page_view.dart';
import 'package:barber_booking_app/features/splash/splash_view.dart';
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

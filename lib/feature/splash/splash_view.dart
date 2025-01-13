import 'package:barber_booking_app/feature/onboarding/onboarding_page_view.dart';
import 'package:barber_booking_app/feature/splash/splash_provider.dart';
import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/widgets/text/wavy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  final splashProvider = StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });
  @override
  void initState() {
    super.initState();
    ref.read(splashProvider.notifier).checkSplashState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      splashProvider,
      (previous, next) {
        if (next.isReaquiredForceUpdate ?? false) {
          showAboutDialog(context: context);
          return;
        }
        if (next.isRedirectHome == true) {
          debugPrint('Navigating to OnboardingPageView...');
          context.route.navigateToPage(const OnboardingPageView());
        }
      },
    );
    return const Scaffold(
      backgroundColor: ColorConstants.darkGreyColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WavyText(title: StringConstants.appName),
          ],
        ),
      ),
    );
  }
}

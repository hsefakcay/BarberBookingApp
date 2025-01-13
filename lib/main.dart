import 'package:barber_booking_app/feature/auth/authentication_view.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/constants/themes.dart';
import 'package:barber_booking_app/product/initialize/application_start.dart';
import 'package:barber_booking_app/product/initialize/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/splash',
      routes: AppRoutes.routes,
      supportedLocales: const [Locale('en', ''), Locale('tr', '')],
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context).darkTheme,
      home: const AuthenticationView(),
    );
  }
}

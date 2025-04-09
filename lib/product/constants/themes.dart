import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

@immutable
class AppTheme {
  const AppTheme(this.context);

  final BuildContext context;
  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        //font tanımlaması
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          color: ColorConstants.blackColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              color: ColorConstants.yellowColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            foregroundColor: ColorConstants.yellowColor, // "Forgotten password?" metninin rengi
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.yellowColor,
            foregroundColor: ColorConstants.blackColor,
            textStyle: const TextStyle(
              color: ColorConstants.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        tabBarTheme: const TabBarThemeData(
          indicatorColor: ColorConstants.yellowColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: ColorConstants.yellowColor,
          fillColor: ColorConstants.darkGreyColor,
          filled: true,

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorConstants.yellowColor),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorConstants.greyColor),
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle:
              const TextStyle(color: ColorConstants.greyColor), // Input alanındaki etiket rengi
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: WidgetStateProperty.all<BorderSide>(
              const BorderSide(color: ColorConstants.darkGreyColor),
            ),
            textStyle: WidgetStateProperty.all<TextStyle?>(
              context.general.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
            backgroundColor: WidgetStateProperty.all(ColorConstants.yellowColor),
            foregroundColor: WidgetStateProperty.all(ColorConstants.blackColor),
          ),
        ),
        scaffoldBackgroundColor: ColorConstants.blackColor,
        checkboxTheme: CheckboxThemeData(fillColor: WidgetStateProperty.all(Colors.green)),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.amber),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.dark(
            onPrimary: ColorConstants.yellowColor,
            onSecondary: ColorConstants.yellowColor,
          ),
        ),

        colorScheme: const ColorScheme.dark(),
      );
}

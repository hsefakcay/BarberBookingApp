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
            textStyle: const TextStyle(
              color: ColorConstants.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: ColorConstants.timeContainerColor,
          filled: true,
          labelStyle:
              const TextStyle(color: ColorConstants.greyColor), // Input alanındaki etiket rengi
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorConstants.greyColor),
          ), // Giriş alanı kenarlığı
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: WidgetStateProperty.all<BorderSide>(
              const BorderSide(color: ColorConstants.darkGreyColor),
            ),
            textStyle: WidgetStateProperty.all<TextStyle?>(
              context.general.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
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
          colorScheme: ColorScheme.dark(
            onPrimary: ColorConstants.yellowColor,
            onSecondary: ColorConstants.yellowColor,
          ),
        ),

        colorScheme: const ColorScheme.dark(),
      );
}

import 'package:barber_booking_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData get darkTheme {
  return ThemeData(
    appBarTheme: AppBarTheme(
      color: blackColor,
    ),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: yellowColor)),
    scaffoldBackgroundColor: blackColor,
    checkboxTheme: CheckboxThemeData(fillColor: WidgetStateProperty.all(Colors.green)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.amber),
    buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.dark(onPrimary: yellowColor, onSecondary: yellowColor)),
    textTheme: ThemeData.dark().textTheme.copyWith(
          headlineLarge: TextStyle(color: whiteColor, fontFamily: "Ubuntu", fontSize: 36),
          headlineMedium: TextStyle(color: whiteColor, fontFamily: "Ubuntu", fontSize: 30),
          headlineSmall: TextStyle(color: whiteColor, fontFamily: "Ubuntu", fontSize: 24),
          bodyLarge: TextStyle(color: whiteColor, fontFamily: "Ubuntu", fontSize: 16),
          bodyMedium: TextStyle(color: whiteColor, fontFamily: "Ubuntu", fontSize: 14),
          bodySmall: TextStyle(color: greyColor, fontFamily: "Ubuntu", fontSize: 10),
          labelMedium: TextStyle(color: greyColor, fontFamily: "Ubuntu", fontSize: 14),
          labelSmall: TextStyle(color: greyColor, fontFamily: "Ubuntu", fontSize: 12),
          labelLarge: TextStyle(
              color: blackColor, fontFamily: "Ubuntu", fontSize: 16, fontWeight: FontWeight.w900),
        ),
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true,
  );
}

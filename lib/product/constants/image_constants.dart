import 'package:flutter/material.dart';

@immutable
enum ImageConstants {
  barber('defaultBarber');

  final String value;
  const ImageConstants(this.value);

  String get toJpg => 'assets/images/$value.jpg';
}

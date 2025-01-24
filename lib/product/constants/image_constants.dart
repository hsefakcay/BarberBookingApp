enum ImageConstants {
  barber('defaultBarber');

  const ImageConstants(this.value);

  final String value;

  String get toJpg => 'assets/images/$value.jpg';
}

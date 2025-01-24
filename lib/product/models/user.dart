class User {
  User(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.favBarbersId,
      required this.favBarberShopsId,});

  final String name;
  final String email;
  final String phoneNumber;
  final List<String> favBarbersId;
  final List<String> favBarberShopsId;
}

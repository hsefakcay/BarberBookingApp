class Service {
  final String name;
  final String price;
  final int duration; // Dakika cinsinden
  bool isSelected;

  Service({
    required this.name,
    required this.price,
    required this.duration,
    this.isSelected = false,
  });
}

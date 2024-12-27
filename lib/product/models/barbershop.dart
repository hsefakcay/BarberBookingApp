class BarberShop {
  BarberShop({
    required this.id,
    required this.name,
    required this.image,
    required this.distance,
    required this.ratings,
  });

  factory BarberShop.fromJson(Map<String, dynamic> json) {
    return BarberShop(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      distance: (json['distance'] as num).toDouble(),
      ratings: (json['ratings'] as num).toDouble(),
    );
  }
  final String id;
  final String name;
  final String image;
  final double distance;
  final double ratings;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'distance': distance,
      'ratings': ratings,
    };
  }
}

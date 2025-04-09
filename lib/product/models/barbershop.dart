class BarberShop {
  BarberShop({
    required this.id,
    required this.name,
    required this.image,
    required this.distance,
    required this.ratings,
    required this.barberIds,
  });

  factory BarberShop.fromJson(Map<String, dynamic> json) {
    return BarberShop(
      id: json['_id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      distance: (json['distance'] as num).toDouble(),
      ratings: (json['ratings'] as num).toDouble(),
      barberIds: (json['barbers'] as List<dynamic>).map((e) => e as int).toList(),
    );
  }

  final int id;
  final String name;
  final String image;
  final double distance;
  final double ratings;
  final List<int> barberIds;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'distance': distance,
      'ratings': ratings,
      'barbers': barberIds,
    };
  }
}

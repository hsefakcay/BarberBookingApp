class Service {
  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      duration: json['duration'] as int,
    );
  }
  final String id;
  final String name;
  final int price;
  final int duration;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'duration': duration,
    };
  }
}

class Service {
  Service({
    required this.name,
    required this.price,
    required this.duration,
    this.id,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      duration: json['duration'] as double,
    );
  }
  int? id;
  final String name;
  final double price;
  final double duration;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'duration': duration,
    };
  }
}

import 'package:barber_booking_app/product/models/service.dart';

class Barber {
  Barber({
    required this.id,
    required this.name,
    required this.photo,
    required this.ratings,
    required this.reviews,
    required this.barberShopId,
    required this.services,
  });

  // JSON'dan Dart objesine dönüştürme
  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
      id: json['_id'] as int,
      name: json['name'] as String,
      photo: json['photo'] as String,
      ratings: (json['ratings'] as num).toDouble(),
      reviews: json['reviews'] as double,
      barberShopId: json['barberShopId'] as int,
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service as Map<String, dynamic>))
          .toList(),
    );
  }
  final int id;
  final String name;
  final String photo;
  final double ratings;
  final double reviews;
  final int barberShopId;
  final List<Service> services;

  // Dart objesinden JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'photo': photo,
      'ratings': ratings,
      'reviews': reviews,
      'barberShopId': barberShopId,
      'services': services.map((service) => service.toJson()).toList(),
    };
  }
}

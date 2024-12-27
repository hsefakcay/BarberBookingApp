import 'package:barber_booking_app/product/models/barbershop.dart';
import 'package:barber_booking_app/product/models/service.dart';

class Barber {
  Barber({
    required this.id,
    required this.name,
    required this.photo,
    required this.ratings,
    required this.reviews,
    required this.barberShop,
    required this.services,
  });

  // JSON'dan Dart objesine dönüştürme
  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
      id: json['_id'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
      ratings: (json['ratings'] as num).toDouble(),
      reviews: json['reviews'] as int,
      barberShop: BarberShop.fromJson(json['barberShop'] as Map<String, dynamic>),
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service as Map<String, dynamic>))
          .toList(),
    );
  }
  final String id;
  final String name;
  final String photo;
  final double ratings;
  final int reviews;
  final BarberShop barberShop;
  final List<Service> services;

  // Dart objesinden JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'photo': photo,
      'ratings': ratings,
      'reviews': reviews,
      'barberShop': barberShop.toJson(),
      'services': services.map((service) => service.toJson()).toList(),
    };
  }
}

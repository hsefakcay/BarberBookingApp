import 'package:barber_booking_app/feature/home_page/home_page_view.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/models/barbershop.dart';
import 'package:barber_booking_app/product/services/barber_service.dart';
import 'package:barber_booking_app/product/services/barber_shop_service.dart';
import 'package:flutter/material.dart';

mixin HomePageMixin on State<HomePage> {
  final BarberService _barberService = BarberService();
  final BarberShopService _barberShopService = BarberShopService();
  late Future<List<Barber>> barbers;
  late Future<List<BarberShop>> barberShops;
  @override
  void initState() {
    super.initState();
    barbers = _barberService.fetchBarbers();
    barberShops = _barberShopService.fetchBarberShops();
  }
}

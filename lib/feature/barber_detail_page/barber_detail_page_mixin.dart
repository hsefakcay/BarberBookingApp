import 'package:barber_booking_app/feature/barber_detail_page/barber_detail_page_view.dart';
import 'package:barber_booking_app/product/models/service.dart';
import 'package:barber_booking_app/product/services/service_service.dart';
import 'package:flutter/material.dart';

mixin BarberDetailPageMixin on State<BarberDetailPage> {
  final ServiceService _serviceService = ServiceService();
  late Future<List<Service>> services;

  @override
  void initState() {
    super.initState();
    services = _serviceService.fetchServices();
  }
}

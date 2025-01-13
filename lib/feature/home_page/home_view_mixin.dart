import 'package:barber_booking_app/feature/home_page/home_provider.dart';
import 'package:barber_booking_app/feature/home_page/home_view.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/models/barbershop.dart';
import 'package:barber_booking_app/product/services/barber_service.dart';
import 'package:barber_booking_app/product/services/barber_shop_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin HomeViewMixin on ConsumerState<HomeView> {
  final BarberService _barberService = BarberService();
  final BarberShopService _barberShopService = BarberShopService();
  late Future<List<Barber>> barbers;
  late Future<List<BarberShop>> barberShops;
  final homeProvider = StateNotifierProvider<HomeProvider, AsyncValue<String>>(
    (ref) => HomeProvider(),
  );

  @override
  void initState() {
    super.initState();
    barbers = _barberService.fetchBarbers();
    barberShops = _barberShopService.fetchBarberShops();
    ref.read(homeProvider.notifier).fetchUserName();
  }
}

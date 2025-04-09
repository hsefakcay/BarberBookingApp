import 'package:barber_booking_app/core/network/api_endpoints.dart';
import 'package:barber_booking_app/core/network/dio_client.dart';
import 'package:barber_booking_app/product/models/barbershop.dart';
import 'package:dio/dio.dart';

class BarberShopService {
  final Dio _dio = DioClient().dio;

  // Tüm barber shop'ları getir
  Future<List<BarberShop>> fetchBarberShops() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.getBarberShops);
      if (response.statusCode == 200) {
        final data = response.data?['data'] as Map<String, dynamic>;
        final barberShopJson = data['shops'] as List<dynamic>;
        return barberShopJson
            .map((json) => BarberShop.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load barbers');
      }
    } catch (e) {
      throw Exception('Error fetching barbers: $e');
    }
  }

  // Yeni bir barber shop oluşturma
  Future<BarberShop> createBarberShop(BarberShop barberShop) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/barbershops',
        data: barberShop.toJson(),
      );
      if (response.statusCode == 201) {
        final data = response.data?['data'] as Map<String, dynamic>;
        return BarberShop.fromJson(data['shop'] as Map<String, dynamic>);
      } else {
        throw Exception('Failed to create barber shop');
      }
    } catch (e) {
      throw Exception('Error creating barber shop: $e');
    }
  }
}

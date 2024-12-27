import 'package:barber_booking_app/core/network/api_endpoints.dart';
import 'package:barber_booking_app/core/network/dio_client.dart';
import 'package:barber_booking_app/product/models/service.dart';
import 'package:dio/dio.dart';

class ServiceService {
  final Dio _dio = DioClient().dio;

  // Tüm servisleri çekme
  Future<List<Service>> fetchServices() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.getBarberServices);
      if (response.statusCode == 200) {
        final servicesJson = response.data?['data']['services'] as List<dynamic>;
        return servicesJson.map((json) => Service.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Error fetching services: $e');
    }
  }

  // Yeni bir servis oluşturma
  Future<Service> createService(Service service) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/services',
        data: service.toJson(),
      );
      if (response.statusCode == 201) {
        return Service.fromJson(response.data?['data']['service'] as Map<String, dynamic>);
      } else {
        throw Exception('Failed to create service');
      }
    } catch (e) {
      throw Exception('Error creating service: $e');
    }
  }
}

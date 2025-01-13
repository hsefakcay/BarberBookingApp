import 'package:barber_booking_app/core/network/api_endpoints.dart';
import 'package:barber_booking_app/core/network/dio_client.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:dio/dio.dart';

class BarberService {
  final Dio _dio = DioClient().dio;

  Future<List<Barber>> fetchBarbers() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.getBarbers);
      if (response.statusCode == 200) {
        final barbersJson = response.data?['data']['barbers'] as List<dynamic>;
        return barbersJson.map((json) => Barber.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load barbers');
      }
    } catch (e) {
      throw Exception('Error fetching barbers: $e');
    }
  }

  // Yeni bir berber oluşturma
  Future<Barber> createBarber(Barber barber) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/barberservices',
        data: barber.toJson(),
      );
      if (response.statusCode == 201) {
        return Barber.fromJson(response.data?['data']['services'] as Map<String, dynamic>);
      } else {
        throw Exception('Failed to create barber');
      }
    } catch (e) {
      throw Exception('Error creating barber: $e');
    }
  }

  Future<List<Barber>> fetchFavoriteBarbersDetails() async {
    try {
      // Favori berber ID'lerini Firebase'den al
      final favoriteBarberIds = await FirebaseService.fetchFavoriteBarbers();

      if (favoriteBarberIds.isEmpty) {
        print('No favorite barbers found.');
        return [];
      }
      // Favori berberlerin bilgilerini al
      final favoriteBarbers = <Barber>[];
      for (String barberId in favoriteBarberIds) {
        final response = await _dio.get<Map<String, dynamic>>(
          '${ApiEndpoints.getBarbers}/$barberId',
        );

        if (response.statusCode == 200) {
          final barberJson = response.data?['data']['barber'] as Map<String, dynamic>;
          final barber = Barber.fromJson(barberJson);
          favoriteBarbers.add(barber);
        } else {
          print('Failed to fetch barber with ID: $barberId');
        }
      }

      return favoriteBarbers;
    } catch (e) {
      print('Error fetching favorite barber details: $e');
      return [];
    }
  }
}

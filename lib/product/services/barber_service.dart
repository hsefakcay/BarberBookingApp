import 'package:barber_booking_app/core/network/api_endpoints.dart';
import 'package:barber_booking_app/core/network/dio_client.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class BarberService {
  final Dio _dio = DioClient().dio;

  Future<List<Barber>> fetchBarbers() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.getBarbers);
      if (response.statusCode == 200) {
        final dataData = response.data?['data'] as Map<String, dynamic>; // Explicit cast
        final barbersList = (dataData['barbers'] as List)
            .map((barber) => Barber.fromJson(barber as Map<String, dynamic>))
            .toList();
        return barbersList;
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
        ApiEndpoints.getBarbers,
        data: barber.toJson(),
      );
      if (response.statusCode == 201) {
        final dataData = response.data?['data'] as Map<String, dynamic>; // Explicit cast
        return Barber.fromJson(dataData['services'] as Map<String, dynamic>);
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
        Logger('No favorite barbers found.');
        return [];
      }
      // Favori berberlerin bilgilerini al
      final favoriteBarbers = <Barber>[];
      for (final barberId in favoriteBarberIds) {
        final response = await _dio.get<Map<String, dynamic>>(
          '${ApiEndpoints.getBarbers}/$barberId',
        );

        if (response.statusCode == 200) {
          final dataData = response.data?['data'] as Map<String, dynamic>; // Explicit cast
          final barberJson = dataData['barber'] as Map<String, dynamic>;
          final barber = Barber.fromJson(barberJson);
          favoriteBarbers.add(barber);
        } else {
          throw Exception('Failed to fetch barber with ID: $barberId');
        }
      }

      return favoriteBarbers;
    } catch (e) {
      throw Exception('Error fetching favorite barber details: $e');
    }
  }
}

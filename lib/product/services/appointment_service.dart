import 'package:barber_booking_app/core/network/api_endpoints.dart';
import 'package:barber_booking_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class AppointmentService {
  final Dio _dio = DioClient().dio;

  Future<List<String>> fetchBookedTimes(String barberId, String date) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.getAppointments}?barberId=$barberId&date=2025-01-${int.parse(date) + 1}',
      );

      if (response.statusCode == 200) {
        // response.data'ya direkt erişim yerine, önce verinin tipini kontrol et
        final dynamic data = response.data;

        // Eğer veri bir List ise, her öğeyi String'e dönüştür
        if (data is List) {
          return data.map((e) => e.toString()).toList();
        } else {
          throw Exception('Expected a list of strings');
        }
      } else {
        throw Exception('Failed to fetch booked times. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch booked times: $e');
    }
  }

  Future<bool> addAppointment(String barberId, String userId, String date, String time) async {
    try {
      final data = {'barberId': barberId, 'userId': userId, 'date': date, 'time': time};

      // POST isteğini gönderiyoruz
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.getAppointments,
        data: data,
      );
      // Başarılı bir cevap aldıysak (201 veya 200), `true` döndür
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Hata durumunda bir exception fırlat
      print('Error adding appointment: $e');
      return false;
    }
  }
}

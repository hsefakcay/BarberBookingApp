import 'package:barber_booking_app/core/network/api_endpoints.dart';
import 'package:barber_booking_app/core/network/dio_client.dart';
import 'package:barber_booking_app/product/models/appointment.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class AppointmentService {
  final Dio _dio = DioClient().dio;

  String formatDate(String date) {
    try {
      // Gelen tarihi belirtilen input formatında parse et
      final parsedDate = DateFormat('d EEE MMMM y', 'en_US').parse(date);
      // Tarihi hedef formata dönüştür
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      throw FormatException('Invalid date or format: $e');
    }
  }

  Future<bool> addAppointment(Appointment appointment) async {
    try {
      final formattedDate = formatDate(appointment.date);
      final data = {
        'barberId': appointment.barberId,
        'userId': appointment.userId,
        'date': formattedDate,
        'time': appointment.time,
      };

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
    } on () {
      // Hata durumunda bir exception fırlat
      Logger('Error adding appointment');
      return false;
    }
  }

  Future<List<String>> fetchBookedTimesByBarber(String barberId, String date) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.getAppointments}?barberId=$barberId&date=${formatDate(date)}',
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

  Future<List<Appointment>> fetchBookedDatesByUser() async {
    final userId = FirebaseService.fetchCurrentUser()?.uid ?? '';
    try {
      final response = await _dio.get<List<dynamic>>(
        '${ApiEndpoints.getAppointments}/user/$userId',
      );

      if (response.statusCode == 200) {
        // response.data'ya direkt erişim yerine, önce verinin tipini kontrol et
        final appointmentJson = response.data!;
        final list = appointmentJson
            .map((json) => Appointment.fromJson(json as Map<String, dynamic>))
            .toList();
        return list;
      } else {
        throw Exception('Failed to fetch booked times. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch booked times: $e');
    }
  }
}

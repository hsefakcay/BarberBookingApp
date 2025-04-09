import 'package:barber_booking_app/core/network/api_endpoints.dart';
import 'package:barber_booking_app/core/network/dio_client.dart';
import 'package:barber_booking_app/product/models/appointment.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class AppointmentService {
  final Dio _dio = DioClient().dio;

  // ignore: buradan kaldırılmalı bu metot
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

// add new appointment
  Future<bool> addAppointment(Appointment appointment) async {
    try {
      final formattedDate = formatDate(appointment.date);
      final data = appointment.toJson();
      data['date'] = formattedDate;

      // POST isteğini gönderiyoruz
      final response = await _dio.post(
        ApiEndpoints.getAppointments,
        data: data,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add appointment. Status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      // Fix syntax here
      Logger('''
              Dio Error!
              Status: ${dioError.response?.statusCode}
              Data: ${dioError.response?.data}
              Message: ${dioError.message}
              ''');
      return false;
    } catch (e) {
      Logger('Unexpected error: $e');
      return false;
    }
  }

  Future<List<String>> fetchBookedTimesByBarber(String barberId, String date) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '${ApiEndpoints.getAppointments}?barberId=$barberId&date=${formatDate(date)}',
      );

      if (response.statusCode == 200) {
        // response.data'ya direkt erişim yerine, önce verinin tipini kontrol et
        final dynamic data = response.data;

        // Eğer veri bir List ise, her öğeyi String'e dönüştür
        if (data is List) {
          return data.map((e) => e['time'].toString()).toList();
        } else {
          throw Exception('Expected a list of strings');
        }
      } else {
        throw Exception('Failed to fetch booked times. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
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

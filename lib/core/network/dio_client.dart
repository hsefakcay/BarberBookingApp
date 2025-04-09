import 'package:dio/dio.dart';

class DioClient {
  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.2.98:5070/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(milliseconds: 5000),
      ),
    );

    // Interceptors ekleyerek loglama veya hata yönetimi yapılabilir.
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  // Tek bir instance
  static final DioClient _instance = DioClient._internal();

  late Dio dio;
}

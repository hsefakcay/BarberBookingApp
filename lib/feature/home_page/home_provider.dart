import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends StateNotifier<AsyncValue<String>> {
  HomeProvider() : super(const AsyncValue.loading()); // Başlangıçta loading

  Future<void> fetchUserName() async {
    try {
      state = const AsyncValue.loading(); // Yükleme durumu başlatılır
      final userName = await FirebaseService.fetchUserName();

      if (userName != null) {
        state = AsyncValue.data(userName);
      } else {
        state = const AsyncValue.error(
          'User not found.',
          StackTrace.empty,
        ); // Kullanıcı bulunamazsa hata durumu
      }
    } catch (e) {
      state = AsyncValue.error('Error fetching name: $e', StackTrace.empty);
    }
  }
}

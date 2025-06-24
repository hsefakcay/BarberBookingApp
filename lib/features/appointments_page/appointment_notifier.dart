import 'package:barber_booking_app/product/models/appointment.dart';
import 'package:barber_booking_app/product/services/appointment_service.dart';
import 'package:riverpod/riverpod.dart';

class AppointmentNotifier extends StateNotifier<AsyncValue<List<Appointment>>> {
  AppointmentNotifier() : super(const AsyncValue.loading());

  Future<void> fetchAppointments() async {
    try {
      final userAppointments = await AppointmentService().fetchBookedDatesByUser();
      state = AsyncValue.data(userAppointments);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, AsyncValue<List<Appointment>>>(
  (ref) => AppointmentNotifier(),
);

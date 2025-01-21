import 'package:barber_booking_app/feature/appointments_page/appointment_card.dart';
import 'package:barber_booking_app/feature/appointments_page/appointment_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentListView extends ConsumerWidget {
  const AppointmentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentState = ref.watch(appointmentProvider);

    return Scaffold(
      body: appointmentState.when(
        data: (appointments) => appointments.isEmpty
            ? const Center(child: Text('No appointments found.'))
            : ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return AppointmentCard(appointment: appointment);
                },
              ),
        loading: () {
          // İlk kez yükleme yapılacaksa burayı tetikle
          ref.read(appointmentProvider.notifier).fetchAppointments();
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

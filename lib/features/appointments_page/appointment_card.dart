import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({required this.appointment, super.key});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // TO DO: fetch barber data
              appointment.barberId.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    Text(appointment.date),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined),
                    Text(appointment.time),
                  ],
                ),
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorConstants.greenColor,
                      maxRadius: 10,
                    ),
                    Text(StringConstants.confirmed),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Cancel Logic
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.greyColor),
                  child: Text(
                    StringConstants.cancel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Reschedule Logic
                  },
                  child: const Text(StringConstants.reshedule),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

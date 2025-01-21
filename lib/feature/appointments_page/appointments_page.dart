import 'package:barber_booking_app/feature/appointments_page/appointment_list_view.dart';
import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}



class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.yourAppointments),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: StringConstants.upcoming,
                height: 50,
              ),
              Tab(
                text: StringConstants.pass,
                height: 50,
              ),
            ],
            dividerColor: ColorConstants.greyButtonColor,
            indicatorColor: ColorConstants.yellowColor,
            labelColor: ColorConstants.yellowColor,
          ),
        ),
        body: const TabBarView(
          children: [
            AppointmentListView(),
            AppointmentListView(),
          ],
        ),
      ),
    );
  }
}

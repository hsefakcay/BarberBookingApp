import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/models/appointment.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/services/appointment_service.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<dynamic> bottomSheet(BuildContext context, Barber barber) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    builder: (context) {
      return BottomSheetScreen(
        barber: barber,
      );
    },
  );
}

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({
    required this.barber,
    super.key,
  });
  final Barber barber;

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

List<String> generateDates(int numberOfDays) {
  final now = DateTime.now();
  return List.generate(
    numberOfDays,
    (index) => DateFormat('d EEE MMMM y').format(
      now.add(Duration(days: index)),
    ),
  );
}

List<String> generateTimeSlots() {
  final timeSlots = <String>[];
  for (var hour = 9; hour <= 20; hour++) {
    timeSlots.add('$hour:00');
  }
  return timeSlots;
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  final now = DateTime.now();
  String monthName = DateFormat.MMMM().format(DateTime.now());
  String selectedDate = '';
  String selectedTime = '';
  List<String> dates = generateDates(30); // 30 gün için liste
  List<String> timeSlots = generateTimeSlots();
  List<String> bookedTimes = [];

  @override
  void initState() {
    super.initState();
    selectedDate = dates.first;
    fetchBookedTimes();
  }

  Future<void> fetchBookedTimes() async {
    final times = await getBookedTimes(widget.barber.id, selectedDate);
    setState(() {
      bookedTimes = times;
    });
  }

  Future<List<String>> getBookedTimes(String barberId, String date) async {
    return AppointmentService().fetchBookedTimesByBarber(barberId, date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.87,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: ColorConstants.darkGreyColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleText(context),
            _monthSelector(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            _dateSelector(context),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            _timeSelector(context, bookedTimes),
            _saveButton(context),
          ],
        ),
      ),
    );
  }

  Padding _titleText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 7),
      child: Text(
        StringConstants.dateAndTime,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 22,
            ),
      ),
    );
  }

  SizedBox _saveButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.darkGreyColor,
          border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.yellowColor,
            ),
            onPressed: () async {
              await AppointmentService().addAppointment(
                Appointment(
                  userId: FirebaseService.fetchCurrentUser()?.uid ?? '',
                  barberId: widget.barber.id,
                  date: selectedDate,
                  time: selectedTime,
                ),
              );
              Navigator.pop(context);
            },
            child: Text(
              StringConstants.save,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorConstants.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Container _monthSelector() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.greyButtonColor,
        border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConstants.yellowColor,
            ),
          ),
          Text('${monthName.toUpperCase()}  ${now.year}'),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: ColorConstants.yellowColor,
            ),
          ),
        ],
      ),
    );
  }

  Column _timeSelector(BuildContext context, List<String> bookedTimes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TIME', style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.39,
          child: GridView.builder(
            itemCount: timeSlots.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: MediaQuery.sizeOf(context).height * 0.052,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (!bookedTimes.contains(timeSlots[index])) {
                      selectedTime = timeSlots[index];
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: bookedTimes.contains(timeSlots[index])
                        ? ColorConstants.darkGreyColor
                        : selectedTime == timeSlots[index]
                            ? ColorConstants.yellowColor
                            : ColorConstants.borderDarkColor,
                    border: Border.all(
                      color: ColorConstants.greyButtonColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      timeSlots[index],
                      style: selectedTime == timeSlots[index]
                          ? Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: ColorConstants.blackColor)
                          : Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column _dateSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DATE', style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
        SizedBox(
          height: MediaQuery.sizeOf(context).width * 0.17,
          child: ListView.builder(
            itemCount: 30,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = dates[index];
                    monthName = selectedDate.substring(6, 14);
                    getBookedTimes(widget.barber.id, selectedDate);
                    fetchBookedTimes();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: DateContainer(
                    date: dates[index].substring(0, 6),
                    isSelected: selectedDate == dates[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DateContainer extends StatefulWidget {
  const DateContainer({
    required this.isSelected,
    required this.date,
    super.key,
  });

  final bool isSelected;
  final String date;

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isSelected ? ColorConstants.yellowColor : ColorConstants.darkGreyColor,
        border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      width: widget.isSelected
          ? MediaQuery.sizeOf(context).width * 0.2
          : MediaQuery.sizeOf(context).width * 0.15,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.date.substring(0, 2),
              style: widget.isSelected
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              widget.date.substring(2),
              style: widget.isSelected
                  ? Theme.of(context).textTheme.labelLarge
                  : Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

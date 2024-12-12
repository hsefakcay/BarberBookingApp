// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:barber_booking_app/core/constants/colors.dart';
import 'package:barber_booking_app/product/widgets/bottom_bar_button_widget.dart';

Future bottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.sizeOf(context).height * 0.87,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: darkGreyColor,
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
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 7),
                child: Text("DATE & TIME",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 22)),
              ),
              Container(
                decoration: BoxDecoration(
                  color: greyButtonColor,
                  border: Border.all(color: borderDarkColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_rounded, color: yellowColor),
                    ),
                    Text("AUGUST 2024"),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_rounded, color: yellowColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("DATE", style: Theme.of(context).textTheme.labelMedium),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.15,
                    child: ListView.builder(
                      itemCount: 30,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: DateContainer(
                            backgroundColor:
                                index == 0 ? yellowColor : timeContainerColor ?? yellowColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Text("TIME", style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.39,
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: MediaQuery.sizeOf(context).height * 0.052,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: index % 5 == 1 ? greyButtonColor : darkGreyColor,
                        border: Border.all(color: borderDarkColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(" ${index + 9} : 00",
                              style: index % 5 == 1
                                  ? Theme.of(context).textTheme.bodyMedium
                                  : Theme.of(context).textTheme.labelMedium)),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Container(
                  decoration: BoxDecoration(
                      color: darkGreyColor,
                      border: Border.all(color: borderDarkColor, width: 2),
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: yellowColor),
                        onPressed: () {},
                        child: Text(
                          "SAVE",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: blackColor, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class DateContainer extends StatelessWidget {
  const DateContainer({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderDarkColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.sizeOf(context).width * 0.18,
      width: MediaQuery.sizeOf(context).width * 0.15,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("25", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: whiteColor)),
          Text("FRI", style: Theme.of(context).textTheme.labelSmall),
        ],
      )),
    );
  }
}

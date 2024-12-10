import 'package:barber_booking_app/core/constants/colors.dart';
import 'package:barber_booking_app/core/constants/sizes.dart';
import 'package:barber_booking_app/model/barber_model.dart';
import 'package:barber_booking_app/model/service_model.dart';
import 'package:flutter/material.dart';

class BarberDetailPage extends StatefulWidget {
  const BarberDetailPage({super.key, required this.barber});
  final Barber barber;

  @override
  State<BarberDetailPage> createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage> {
  List<Service> services = [
    Service(name: "Haircut", price: "\$20.99", duration: 40),
    Service(name: "Kids Cut", price: "\$15.99", duration: 30),
    Service(name: "Beard Cut", price: "\$15.99", duration: 20),
    Service(name: "Buzz Cut", price: "\$18.99", duration: 30),
    Service(name: "Hair Color", price: "\$25.99", duration: 50),
  ];
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Positioned(
            child: IgnorePointer(
              ignoring: true,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Image.asset(
                  alignment: Alignment.topCenter,
                  "assets/images/${widget.barber.photo}",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
              top: 30,
              left: 20,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: blackColor,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_rounded, color: whiteColor)))),
          Positioned(
              top: 30,
              right: 20,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: blackColor,
                child:
                    IconButton(onPressed: () {}, icon: Icon(Icons.save_rounded, color: whiteColor)),
              )),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.35,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              color: yellowColor,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("PRO BARBER",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: blackColor, fontWeight: FontWeight.w900)),
                              )),
                          Text(widget.barber.name,
                              style: Theme.of(context).textTheme.headlineSmall),
                          Row(children: [
                            Icon(Icons.star_sharp, size: IconSizes.mediumIcon, color: yellowColor),
                            Text(widget.barber.ratings.toString(),
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(" - ${widget.barber.reviews} reviews",
                                style: Theme.of(context).textTheme.bodySmall)
                          ])
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: darkGreyColor,
                                border: Border.all(color: borderDarkColor, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "FRIDAY, AUGUST 25",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: yellowColor),
                                      ),
                                      Text("15:00-16:00",
                                          style: Theme.of(context).textTheme.bodyLarge)
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _showBottomSheet(context);
                                      },
                                      icon: const Icon(Icons.edit_outlined,
                                          size: IconSizes.largeIcon))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.35,
                            decoration: BoxDecoration(
                                color: darkGreyColor,
                                border: Border.all(color: borderDarkColor, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: ListView.builder(
                                  itemCount: services.length,
                                  itemBuilder: (context, index) {
                                    var service = services[index];

                                    return Column(
                                      children: [
                                        SwitchListTile(
                                          title: Text(
                                            service.name,
                                            style: const TextStyle(
                                              color: Colors.white, // Yazı rengi
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "${service.price} - ${service.duration} min",
                                            style: const TextStyle(
                                              color: Colors.grey, // Alt yazı rengi
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: service.isSelected, // Her öğe için durum
                                          activeColor: Colors.yellow,
                                          onChanged: (newValue) {
                                            setState(() {
                                              service.isSelected = newValue; // Durum güncelleniyor
                                            });
                                          },
                                        ),
                                        Divider(color: greyColor, indent: 10, endIndent: 10),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.8,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(color: darkGreyColor, borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("DATE & TIME"),
                Container(
                  decoration: BoxDecoration(
                      color: darkGreyColor,
                      border: Border.all(color: borderDarkColor, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_rounded)),
                      Text("AUGUST 2024"),
                      IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_rounded)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text("DATE"),
                    Container(
                      child: Text("25"),
                      height: 50,
                      width: 50,
                      color: yellowColor,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text("TIME"),
                    Container(
                      height: 100,
                      width: 100,
                      color: yellowColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

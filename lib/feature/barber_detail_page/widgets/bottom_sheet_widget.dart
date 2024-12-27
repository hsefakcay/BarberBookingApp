import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';

Future<dynamic> bottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    builder: (context) {
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
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 7),
                child: Text(
                  'DATE & TIME',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 22),
                ),
              ),
              Container(
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
                      icon: const Icon(Icons.arrow_back_rounded, color: ColorConstants.yellowColor),
                    ),
                    const Text('AUGUST 2024'),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_rounded,
                          color: ColorConstants.yellowColor,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DATE', style: Theme.of(context).textTheme.labelMedium),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.15,
                    child: ListView.builder(
                      itemCount: 30,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: DateContainer(
                            backgroundColor: index == 0
                                ? ColorConstants.yellowColor
                                : ColorConstants.timeContainerColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Text('TIME', style: Theme.of(context).textTheme.labelMedium),
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
                        color: index % 5 == 1
                            ? ColorConstants.greyButtonColor
                            : ColorConstants.darkGreyColor,
                        border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          ' ${index + 9} : 00',
                          style: index % 5 == 1
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstants.darkGreyColor,
                      border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
                      borderRadius: BorderRadius.circular(50),),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: ColorConstants.yellowColor),
                        onPressed: () {},
                        child: Text(
                          'SAVE',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.blackColor, fontWeight: FontWeight.bold,),
                        ),),
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
    required this.backgroundColor, super.key,
  });

  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: ColorConstants.borderDarkColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.sizeOf(context).width * 0.18,
      width: MediaQuery.sizeOf(context).width * 0.15,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('25',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: ColorConstants.whiteColor),),
          Text('FRI', style: Theme.of(context).textTheme.labelSmall),
        ],
      ),),
    );
  }
}

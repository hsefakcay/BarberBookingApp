import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/enums/icon_size.dart';
import 'package:barber_booking_app/product/models/barber.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({
    required this.barber,
    super.key,
  });
  final Barber barber;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool isFavoriteAdded = false;

  @override
  Widget build(BuildContext context) {
    final barberId = widget.barber.id;
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorConstants.blackColor,
      child: InkWell(
        onTap: () {
          // Favorilere ekleme işlemi
          FirebaseService.addFavoriteBarber(barberId);
          setState(() {
            isFavoriteAdded = !isFavoriteAdded;
          });
          //Snack bar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: ColorConstants.greyColor,
              content: Text("Favorilere eklendi!"),
            ),
          );
        },
        child: Icon(
          isFavoriteAdded ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          color: ColorConstants.whiteColor,
          size: IconSize.normal.value,
        ),
      ),
    );
  }
}

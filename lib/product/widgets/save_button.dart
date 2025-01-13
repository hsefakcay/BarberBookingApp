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
  void initState() {
    super.initState();
    _checkFavoriteStatus(); // Asenkron işlemi başlat
  }

  Future<void> _checkFavoriteStatus() async {
    final result = await FirebaseService.isFavoriteBarber(widget.barber.id);
    setState(() {
      isFavoriteAdded = result; // Ekranı güncelle
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorConstants.blackColor,
      child: InkWell(
        onTap: () {
          setState(() {
            isFavoriteAdded = !isFavoriteAdded;
          });
          // Favorilere ekleme işlemi
          isFavoriteAdded == true
              ? FirebaseService.addFavoriteBarber(widget.barber.id)
              : FirebaseService.deleteFavoriteBarber(widget.barber.id);
        },
        child: _saveIcon(),
      ),
    );
  }

  Icon _saveIcon() {
    return Icon(
      isFavoriteAdded ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
      color: ColorConstants.whiteColor,
      size: IconSize.normal.value,
    );
  }
}

import 'package:barber_booking_app/product/utility/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Container(
        decoration: AppDecoration.standardBorderDecoration(),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: onTap,
        ),
      ),
    );
  }
}

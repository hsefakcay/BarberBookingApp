import 'package:barber_booking_app/feature/profile_page/profil_page_view.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/widgets/custom_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.settings),
      ),
      body: ListView(
        padding: context.padding.normal,
        children: [
          CustomListTile(
            icon: Icons.person,
            title: StringConstants.profile,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfilePage>(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          CustomListTile(
              icon: Icons.notifications, title: StringConstants.notifications, onTap: () {}),
          CustomListTile(icon: Icons.language, title: StringConstants.language, onTap: () {}),
          CustomListTile(icon: Icons.help, title: StringConstants.helpsAndSupport, onTap: () {}),
        ],
      ),
    );
  }
}

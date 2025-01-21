import 'package:barber_booking_app/feature/auth/authentication_view.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/widgets/custom_list_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              Navigator.pushNamed(context, '/profile');
            },
          ),
          CustomListTile(
            icon: Icons.favorite_border_rounded,
            title: StringConstants.favorites,
            onTap: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
          CustomListTile(
            icon: Icons.bookmark_outline,
            title: StringConstants.appointments,
            onTap: () {
              Navigator.pushNamed(context, '/appointments');
            },
          ),
          CustomListTile(
            icon: Icons.notifications_none_outlined,
            title: StringConstants.notifications,
            onTap: () {},
          ),
          CustomListTile(icon: Icons.language, title: StringConstants.language, onTap: () {}),
          CustomListTile(icon: Icons.help, title: StringConstants.helpsAndSupport, onTap: () {}),
          CustomListTile(
            icon: Icons.logout_outlined,
            title: StringConstants.logout,
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                // Çıkış yaptıktan sonra login ekranına yönlendirme
                if (mounted) {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<AuthenticationView>(
                      builder: (context) => const AuthenticationView(),
                    ),
                  );
                }
              } catch (e) {
                // Hata durumunda kullanıcıya bir mesaj göster
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error signing out: $e')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

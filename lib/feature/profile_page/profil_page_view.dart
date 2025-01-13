import 'dart:io';

import 'package:barber_booking_app/feature/home_page/home_provider.dart';
import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  File? _profileImage; // Profil fotoğrafı için değişken
  final TextEditingController _nameController = TextEditingController();
  final homeProvider = StateNotifierProvider<HomeProvider, AsyncValue<String>>(
    (ref) => HomeProvider(),
  );

  @override
  void initState() {
    super.initState();
    ref.read(homeProvider.notifier).fetchUserName();
  }

  // Fotoğraf seçme fonksiyonu
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage, // Fotoğraf yükleme işlemini başlatır
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!) // Seçilen fotoğraf
                      : const AssetImage('assets/images/default_profile.jpg')
                          as ImageProvider, // Varsayılan fotoğraf
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.camera_alt, size: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Bilgileri kaydetme işlemi
                if (_nameController.text.isNotEmpty) {
                  await FirebaseService.updateUserName(_nameController.text, context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Profile updated!',
                        style: TextStyle(color: ColorConstants.whiteColor),
                      ),
                      backgroundColor: ColorConstants.darkGreyColor,
                    ),
                  );
                  await Navigator.pushNamed(context, '/home');
                  // Profil bilgilerini backend'e veya local storage'a kaydedebilirsin
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: Text(
                'Save Changes',
                style: const TextTheme().bodyLarge?.copyWith(color: ColorConstants.blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:barber_booking_app/feature/onboarding/widgets/onboarding_button.dart';
import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:barber_booking_app/product/constants/string_constants.dart';
import 'package:barber_booking_app/product/enums/icon_size.dart';
import 'package:barber_booking_app/product/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<CompleteProfilePage> {
  File? _profileImage; // Profil fotoğrafı için değişken

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

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
      appBar: AppBar(),
      body: Padding(
        padding: context.padding.medium,
        child: ListView(
          children: [
            Padding(
              padding: context.padding.normal,
              child: Column(
                children: [
                  Text(
                    StringConstants.completeProfileTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    StringConstants.completeProfileSubTitle,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: ColorConstants.greyColor),
                  ),
                ],
              ),
            ),
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
                      child: Icon(Icons.camera_alt, size: IconSize.small.value),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(labelText: StringConstants.name),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: StringConstants.phoneNumber),
            ),
            const SizedBox(height: 20),
            OnboardingButton(
              text: StringConstants.completeProfile,
              onPressed: () async {
                // Bilgileri kaydetme işlemi
                if (_nameController.text.isNotEmpty && _phoneNumberController.text.isNotEmpty) {
                  await FirebaseService.updateUserName(_nameController.text, context);
                  await FirebaseService.updateUserPhoneNumber(_phoneNumberController.text, context);
                  await Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

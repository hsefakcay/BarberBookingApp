import 'package:barber_booking_app/product/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  static User? fetchCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> addFavoriteBarber(String barberId) async {
    final userId = fetchCurrentUser()?.uid ?? '';
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      await userDoc.update(
        {
          'favorite_barbers': FieldValue.arrayUnion([barberId]),
        },
      );
    } catch (e) {
      print('Error adding favorite barber: $e');
    }
  }

  static Future<List<String>> fetchFavoriteBarbers() async {
    final userId = fetchCurrentUser()?.uid ?? ''; // Geçerli kullanıcının UID'sini al
    if (userId.isEmpty) {
      print('User ID is empty. Please ensure the user is logged in.');
      return [];
    }
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    try {
      // Kullanıcı belgesini Firestore'dan al
      final userSnapshot = await userDoc.get();
      // Belgeden favori berberler listesini al
      if (userSnapshot.exists && userSnapshot.data() != null) {
        final data = userSnapshot.data()! as Map<String, dynamic>;

        // Favori berberler alanını al ve doğru türe dönüştür
        if (data['favorite_barbers'] != null && data['favorite_barbers'] is List) {
          final favoriteBarbers = (data['favorite_barbers'] as List<dynamic>)
              .map((e) => e.toString()) // Elemanları String'e dönüştür
              .toList();
          return favoriteBarbers;
        } else {
          print('Favorite barbers field is either null or not a list.');
          return [];
        }
      } else {
        print('User document does not exist or has no data.');
        return [];
      }
    } catch (e) {
      print('Error fetching favorite barbers: $e');
      return [];
    }
  }

  static Future<void> deleteFavoriteBarber(String barberId) async {
    final userId = fetchCurrentUser()?.uid ?? ''; // Kullanıcının UID'sini alın
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      if (userId.isEmpty) {
        print('User is not logged in.');
        return;
      }

      // Firestore'da `arrayRemove` ile `barberId`'yi doğrudan sil
      await userDoc.update({
        'favorite_barbers': FieldValue.arrayRemove([barberId]),
      });

      print('Barber removed from favorites successfully!');
    } catch (e) {
      print('Error removing favorite barber: $e');
    }
  }

// favori berberler içerisinde mi kontrolu yapan metot
  static Future<bool> isFavoriteBarber(String barberId) async {
    final userId = fetchCurrentUser()?.uid ?? ''; // Kullanıcının UID'si

    try {
      if (userId.isEmpty) {
        print('User is not logged in.');
        return false;
      }

      // Kullanıcının favori berberlerini içeren belgeyi sorgula
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, isEqualTo: userId) // Kullanıcı ID'sine göre belgeyi bulun
          .where('favorite_barbers', arrayContains: barberId) // Listeyi kontrol et
          .get();

      // Eğer belge varsa, barberId favori listesindedir
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking favorite barber: $e');
      return false;
    }
  }

  static Future<String?> fetchUserName() async {
    final firestore = FirebaseFirestore.instance;
    try {
      // Kullanıcının belgesini e-posta adresine göre bul
      final querySnapshot = await firestore
          .collection('users') // Kullanıcılar için varsayılan koleksiyon adı
          .where('email', isEqualTo: fetchCurrentUser()?.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // İlk dökümanın 'name' alanını al
        final userName = querySnapshot.docs.first.data()['name'].toString();
        return userName;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Kullanıcı adını Firestore'da güncelleyen fonksiyon
  static Future<void> updateUserName(String newName, BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is not logged in.')),
      );
      return;
    }
    try {
      // Kullanıcı belgesi
      final userDoc = firestore.collection('users').doc(user.uid);

      // Firestore'da kullanıcıyı bul
      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        // Kullanıcıyı Firestore'a ekle
        await userDoc.set({
          'email': user.email,
          'name': newName,
        });
      } else {
        // Firestore'da adı güncelle
        await userDoc.update({'name': newName});
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Name updated successfully!',
            style: TextStyle(color: ColorConstants.whiteColor),
          ),
          backgroundColor: ColorConstants.darkGreyColor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating name: $e')),
      );
    }
  }

// Kullanıcı numarasını Firestore'da güncelleyen fonksiyon
  static Future<void> updateUserPhoneNumber(String newNumber, BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is not logged in.')),
      );
      return;
    }
    try {
      // Kullanıcı belgesi
      final userDoc = firestore.collection('users').doc(user.uid);

      // Firestore'da kullanıcıyı bul
      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        // Kullanıcıyı Firestore'a ekle
        await userDoc.set({
          'email': user.email,
          'phoneNumber': newNumber,
        });
      } else {
        // Firestore'da numarayı güncelle
        await userDoc.update({'phoneNumber': newNumber});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating name: $e')),
      );
    }
  }
}

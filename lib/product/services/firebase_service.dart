import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

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
      throw Exception('Error adding favorite barber: $e');
    }
  }

  static Future<List<String>> fetchFavoriteBarbers() async {
    final userId = fetchCurrentUser()?.uid ?? ''; // Geçerli kullanıcının UID'sini al
    if (userId.isEmpty) {
      throw Exception('User ID is empty. Please ensure the user is logged in.');
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
          Logger('Favorite barbers field is either null or not a list.');
          return [];
        }
      } else {
        Logger('User document does not exist or has no data.');
        return [];
      }
    } on () {
      Logger('Error fetching favorite barbers: ');
      return [];
    }
  }

  static Future<void> deleteFavoriteBarber(String barberId) async {
    final userId = fetchCurrentUser()?.uid ?? ''; // Kullanıcının UID'sini alın
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      if (userId.isEmpty) {
        Logger('User is not logged in.');
        return;
      }

      // Firestore'da `arrayRemove` ile `barberId`'yi doğrudan sil
      await userDoc.update({
        'favorite_barbers': FieldValue.arrayRemove([barberId]),
      });

      Logger('Barber removed from favorites successfully!');
    } on () {
      Logger('Error removing favorite barber: ');
    }
  }

// favori berberler içerisinde mi kontrolu yapan metot
  static Future<bool> isFavoriteBarber(String barberId) async {
    final userId = fetchCurrentUser()?.uid ?? ''; // Kullanıcının UID'si

    try {
      if (userId.isEmpty) {
        Logger('User is not logged in.');
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
    } on () {
      Logger('Error checking favorite barber:');
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
    } on () {
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
    } on FirebaseException catch (e) {
      throw UserUpdateException(e.message);
    }
  }

// Kullanıcı numarasını Firestore'da güncelleyen fonksiyon
  static Future<void> updateUserPhoneNumber(
    String newNumber,
  ) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('user is null ');
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
    } on FirebaseException catch (e) {
      throw Exception('Error Updating user name: ${e.message}');
    }
  }
}

// Özel Hata Sınıfları
class UserNotLoggedInException implements Exception {
  @override
  String toString() => 'Kullanıcı giriş yapmamış.';
}

class UserUpdateException implements Exception {
  UserUpdateException(this.message);
  final String? message;

  @override
  String toString() => "Ad güncellenemedi: ${message ?? 'Bilinmeyen hata'}";
}

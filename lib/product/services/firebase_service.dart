import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static Future<void> deleteFavoriteBarber(String userId, String barberId) async {
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    try {} catch (e) {
      print('Error adding favorite barber: $e');
    }
  }
}

// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdst_VouXKlEQ9GFGJozUsigBs8CFkTtk',
    appId: '1:287734215255:android:7a718a0817b5168139e912',
    messagingSenderId: '287734215255',
    projectId: 'barber-booking-2756',
    storageBucket: 'barber-booking-2756e.firebasestorage.app',
  );
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDAvgRPaum_1MscuYafq56DyE44gUfJGBM',
    appId: '1:287734215255:web:06de7a1fdf574ac739e912',
    messagingSenderId: '287734215255',
    projectId: 'barber-booking-2756e',
    authDomain: 'barber-booking-2756e.firebaseapp.com',
    storageBucket: 'barber-booking-2756e.firebasestorage.app',
    measurementId: 'G-Q4P60VS4DE',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvTJG1oM7ewGTEFbrWMrUx2NCXZL9ZBOg',
    appId: '1:287734215255:ios:333ad940cbfcae9f39e912',
    messagingSenderId: '287734215255',
    projectId: 'barber-booking-2756e',
    storageBucket: 'barber-booking-2756e.firebasestorage.app',
    iosBundleId: 'com.example.barberBookingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvTJG1oM7ewGTEFbrWMrUx2NCXZL9ZBOg',
    appId: '1:287734215255:ios:333ad940cbfcae9f39e912',
    messagingSenderId: '287734215255',
    projectId: 'barber-booking-2756e',
    storageBucket: 'barber-booking-2756e.firebasestorage.app',
    iosBundleId: 'com.example.barberBookingApp',
  );
}
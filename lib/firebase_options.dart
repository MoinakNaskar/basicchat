// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCFx7K-K4kKPsJFV5G08wSu0AhzxY9TsKU',
    appId: '1:539238153848:web:4b79f78e5660af3b2d378d',
    messagingSenderId: '539238153848',
    projectId: 'bassicchat8240',
    authDomain: 'bassicchat8240.firebaseapp.com',
    storageBucket: 'bassicchat8240.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATtK3zXL9zicbGUNpAHNy1SAnPPQjbv0k',
    appId: '1:539238153848:android:b7b39a82cb3bf4072d378d',
    messagingSenderId: '539238153848',
    projectId: 'bassicchat8240',
    storageBucket: 'bassicchat8240.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKGbY3akcE2_aWpsuMJjG4_GFsMSOQsw0',
    appId: '1:539238153848:ios:fdee7ec3227392932d378d',
    messagingSenderId: '539238153848',
    projectId: 'bassicchat8240',
    storageBucket: 'bassicchat8240.appspot.com',
    iosClientId: '539238153848-m4j37382are4fpu5u94ugu3144nv3f2v.apps.googleusercontent.com',
    iosBundleId: 'com.example.basicchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKGbY3akcE2_aWpsuMJjG4_GFsMSOQsw0',
    appId: '1:539238153848:ios:fdee7ec3227392932d378d',
    messagingSenderId: '539238153848',
    projectId: 'bassicchat8240',
    storageBucket: 'bassicchat8240.appspot.com',
    iosClientId: '539238153848-m4j37382are4fpu5u94ugu3144nv3f2v.apps.googleusercontent.com',
    iosBundleId: 'com.example.basicchat',
  );
}

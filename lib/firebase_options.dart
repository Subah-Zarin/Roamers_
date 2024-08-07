// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBD5tC-tyBlkJCoM24UiLFqEiZ7zuqH9Ck',
    appId: '1:248880110904:web:98e5b6b401251d6be8f5cd',
    messagingSenderId: '248880110904',
    projectId: 'roamers-9037f',
    authDomain: 'roamers-9037f.firebaseapp.com',
    databaseURL: 'https://roamers-9037f-default-rtdb.firebaseio.com',
    storageBucket: 'roamers-9037f.appspot.com',
    measurementId: 'G-7HEVWYBQF8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAioWzDx498AA2WrHwfCCBDdnnUrKjsOMs',
    appId: '1:248880110904:android:ea9e8f3e560c14d8e8f5cd',
    messagingSenderId: '248880110904',
    projectId: 'roamers-9037f',
    databaseURL: 'https://roamers-9037f-default-rtdb.firebaseio.com',
    storageBucket: 'roamers-9037f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaD2spHBdGf-LNHTxwbHA-_OzvAWadgMg',
    appId: '1:248880110904:ios:bf27916f8b5e6a16e8f5cd',
    messagingSenderId: '248880110904',
    projectId: 'roamers-9037f',
    databaseURL: 'https://roamers-9037f-default-rtdb.firebaseio.com',
    storageBucket: 'roamers-9037f.appspot.com',
    iosBundleId: 'com.example.roamers',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaD2spHBdGf-LNHTxwbHA-_OzvAWadgMg',
    appId: '1:248880110904:ios:bf27916f8b5e6a16e8f5cd',
    messagingSenderId: '248880110904',
    projectId: 'roamers-9037f',
    databaseURL: 'https://roamers-9037f-default-rtdb.firebaseio.com',
    storageBucket: 'roamers-9037f.appspot.com',
    iosBundleId: 'com.example.roamers',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBD5tC-tyBlkJCoM24UiLFqEiZ7zuqH9Ck',
    appId: '1:248880110904:web:6e25e5355b885d02e8f5cd',
    messagingSenderId: '248880110904',
    projectId: 'roamers-9037f',
    authDomain: 'roamers-9037f.firebaseapp.com',
    databaseURL: 'https://roamers-9037f-default-rtdb.firebaseio.com',
    storageBucket: 'roamers-9037f.appspot.com',
    measurementId: 'G-VT1L62WK1M',
  );

}
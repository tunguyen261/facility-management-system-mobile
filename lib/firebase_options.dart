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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCYGhSDiDg8C3_Hq_yW-qnqdPMmeszmYSM',
    appId: '1:864273680010:web:15dd7295c0cc619fd74f73',
    messagingSenderId: '864273680010',
    projectId: 'facility-management-system-fb',
    authDomain: 'facility-management-system-fb.firebaseapp.com',
    storageBucket: 'facility-management-system-fb.appspot.com',
    measurementId: 'G-BD2J4S7Y51',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYovmcQwmUyEJuMHYGBJtZn5EPd6tbWVE',
    appId: '1:864273680010:android:6ea52033f0c86c45d74f73',
    messagingSenderId: '864273680010',
    projectId: 'facility-management-system-fb',
    storageBucket: 'facility-management-system-fb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWAtCYMpQ88g-UtlJGpqJxhdg8oWyvAGc',
    appId: '1:864273680010:ios:4b07072e897c83d8d74f73',
    messagingSenderId: '864273680010',
    projectId: 'facility-management-system-fb',
    storageBucket: 'facility-management-system-fb.appspot.com',
    androidClientId: '864273680010-b80lfr2l2f3l0jaj3sirrmu0bddvts4h.apps.googleusercontent.com',
    iosClientId: '864273680010-9uckkel4sdbqm7mj4i8dk9r1312qgc61.apps.googleusercontent.com',
    iosBundleId: 'com.example.facilityManagementSystemMobile',
  );
}

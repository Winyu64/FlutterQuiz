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
    apiKey: 'AIzaSyD63shFMPpZI9wih3A9xLdS-PjBsZgZAxE',
    appId: '1:711058718370:web:adc6f3662c8a4248d3e1fb',
    messagingSenderId: '711058718370',
    projectId: 'flutter-project-fe565',
    authDomain: 'flutter-project-fe565.firebaseapp.com',
    storageBucket: 'flutter-project-fe565.appspot.com',
    measurementId: 'G-M382WF5C42',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHFm0WAMIYjWPYyKupoELgvcp6XsEXHJc',
    appId: '1:711058718370:android:bf5716843b61a0a3d3e1fb',
    messagingSenderId: '711058718370',
    projectId: 'flutter-project-fe565',
    storageBucket: 'flutter-project-fe565.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABmPwC6M78dPxams12qGsc8QqoNpv-dsg',
    appId: '1:711058718370:ios:808cddeace876242d3e1fb',
    messagingSenderId: '711058718370',
    projectId: 'flutter-project-fe565',
    storageBucket: 'flutter-project-fe565.appspot.com',
    iosBundleId: 'com.example.flutter69',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABmPwC6M78dPxams12qGsc8QqoNpv-dsg',
    appId: '1:711058718370:ios:808cddeace876242d3e1fb',
    messagingSenderId: '711058718370',
    projectId: 'flutter-project-fe565',
    storageBucket: 'flutter-project-fe565.appspot.com',
    iosBundleId: 'com.example.flutter69',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD63shFMPpZI9wih3A9xLdS-PjBsZgZAxE',
    appId: '1:711058718370:web:0f7b2f2a7973c063d3e1fb',
    messagingSenderId: '711058718370',
    projectId: 'flutter-project-fe565',
    authDomain: 'flutter-project-fe565.firebaseapp.com',
    storageBucket: 'flutter-project-fe565.appspot.com',
    measurementId: 'G-FQ10MTEQXE',
  );

}
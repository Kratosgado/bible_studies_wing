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
    apiKey: 'AIzaSyA7VOEe92c1LBVmfqSkciPkAJXKFXG--rc',
    appId: '1:93150933206:web:d18f6279a1ccbd8150d977',
    messagingSenderId: '93150933206',
    projectId: 'biblestudywing-32f3b',
    authDomain: 'biblestudywing-32f3b.firebaseapp.com',
    storageBucket: 'biblestudywing-32f3b.appspot.com',
    measurementId: 'G-E5MNJ15JF6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQEJ4BNqiZX_rvUvmx-x3jtf-V-3F29sg',
    appId: '1:93150933206:android:3af626be6359e6b350d977',
    messagingSenderId: '93150933206',
    projectId: 'biblestudywing-32f3b',
    storageBucket: 'biblestudywing-32f3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMaN7KB8dRCg8Pczy7iK4jFIsR2d7JvcM',
    appId: '1:93150933206:ios:99b821252fc6dcaa50d977',
    messagingSenderId: '93150933206',
    projectId: 'biblestudywing-32f3b',
    storageBucket: 'biblestudywing-32f3b.appspot.com',
    iosClientId: '93150933206-5chpp3g7n6qf6gdt2u58820b2ln486ij.apps.googleusercontent.com',
    iosBundleId: 'com.example.bibleStudiesWing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMaN7KB8dRCg8Pczy7iK4jFIsR2d7JvcM',
    appId: '1:93150933206:ios:0d53577ac4f300e250d977',
    messagingSenderId: '93150933206',
    projectId: 'biblestudywing-32f3b',
    storageBucket: 'biblestudywing-32f3b.appspot.com',
    iosClientId: '93150933206-sa89gmmbb1ubgpn8deqoim3fo9dcpp91.apps.googleusercontent.com',
    iosBundleId: 'com.example.bibleStudiesWing.RunnerTests',
  );
}

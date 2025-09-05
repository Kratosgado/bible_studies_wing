import 'package:bible_studies_wing/src/screens/home/components/background.image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSignIn.instance.initialize(clientId: '93150933206-nm87qdjqd50roeud31qgcs7h0no963mt.apps.googleusercontent.com',
      serverClientId: '93150933206-rbchbttoqgobsvi0pa79oq66sqokmnmn.apps.googleusercontent.com');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await GetStorage.init();

  runApp(const BackgroundImage(child: MyApp()));
}

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Locally a background message :: :: ${message.messageId}');
}

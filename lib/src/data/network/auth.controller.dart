import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static AuthController get to => Get.find();

  Future handleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    await AppService.preferences.logout();
    // await googleSignIn.disconnect();
    await Get.offNamed(Routes.registerRoute);
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      debugPrint("checking credentials");
      if (user != null) {
        // Check if user data already exists in Firestore
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection("members")
            .where('id', isEqualTo: user.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        debugPrint("checking documents");
        if (documents.isEmpty) {
          // User data doesn't exist, save it to Firestore
          // await saveFormData(user);
          // Navigate to the MemberRegistrationForm and pass user data as arguments
          Get.offNamed(Routes.membershipFormRoute, arguments: user);
          debugPrint("saved form data");
          return;
        }
        // update our shared preferences
        await AppService.preferences.login();
        await Get.offNamed(Routes.homeRoute);
        return;
      }
    } catch (e) {
      Text(e.toString());
      debugPrint(e.toString());
    }
  }
}

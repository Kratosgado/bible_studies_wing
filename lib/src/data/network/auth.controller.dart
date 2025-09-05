import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Future handleSignout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
    await AppService.preferences.logout();
    AppService.currentMember = null;
    await Get.offNamed(Routes.registerRoute);
  }

  Future<void> signInWithGoogle() async {
    User? newUser;
    await AppService.showLoadingPopup(
      asyncFunction: () async {
        try {
          debugPrint(" :: :: checking google auth");
          // TODO: fix google auth
          final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
          final GoogleSignInAuthentication googleAuth =  googleUser.authentication;
          debugPrint(" :: :: checking google auth");
          debugPrint(googleAuth.idToken.toString());

          final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
          );

          final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          final User? user = userCredential.user;

          debugPrint("checking credentials");
          if (user != null) {
            // Check if user data already exists in Firestore
            final QuerySnapshot result = await FirebaseFirestore.instance
                .collection("members")
                .where('id', isEqualTo: user.uid)
                .get();
            final List<DocumentSnapshot> documents = result.docs;
            debugPrint(" :: :: checking documents");
            if (documents.isEmpty) {
              // User data doesn't exist, save it to Firestore
              // await saveFormData(user);
              // Navigate to the MemberRegistrationForm and pass user data as arguments
              newUser = user;
              debugPrint(" :: :: saved form data");
              return;
            }
            // update our shared preferences
            await AppService.preferences
                .login()
                .then((_) async => await Get.put(AppService()).init());
          }
        } catch (e) {
          Text(e.toString());
          Get.snackbar(
            "Error Signing In",
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorManager.deepBblue,
            colorText: Colors.white,
          );
          debugPrint(e.toString());
        }
      },
      message: "Signing in with Google",
      errorMessage: "Failed to Sign in",
      callback: () async => await (newUser != null
          ? Get.offNamed(Routes.membershipFormRoute, arguments: newUser)
          : Get.offNamed(Routes.homeRoute)),
    );
  }
}

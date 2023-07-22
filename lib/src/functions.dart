import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future handleSignout() async {
  await auth.signOut();
  await googleSignIn.signOut();
  await googleSignIn.disconnect();
}

void signInWithGoogle(BuildContext context) async {
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
      //check is already sign up
      debugPrint("getting info from database");
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where('id', isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        //update data to server if new user
        FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'nickname': user.displayName,
            'photoUrl': user.photoURL,
            'id': user.uid,
          },
        );
      }
      // Navigator.pushReplacementNamed(context, ConversationPage.routename);
    }
  } catch (e) {
    Text(e.toString());
    debugPrint(e.toString());
  }
}

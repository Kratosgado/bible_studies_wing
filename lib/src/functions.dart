import 'package:bible_studies_wing/src/screens/auth/member_registration_form.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'data/models/member.dart';

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
      // Check if user data already exists in Firestore
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("members")
          .where('id', isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      debugPrint("checking documents");
      if (documents.isEmpty) {
        // User data doesn't exist, save it to Firestore
        await saveFormData(user);
        debugPrint("saved form data");
      }

      // Navigate to the MemberRegistrationForm and pass user data as arguments
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MemberRegistrationForm(
              user: user,
            ),
          ),
        );
      }
    }
  } catch (e) {
    Text(e.toString());
    debugPrint(e.toString());
  }
}

Future saveFormData(User user) async {
  final firestore = FirebaseFirestore.instance;

  Member newMember = Member(
    id: user.uid,
    name: user.displayName ?? 'Unknown',
    photoUrl: user.photoURL ?? '',
    birthdate: DateTime(4),
    contact: user.phoneNumber ?? '',
    executive: false,
    hall: '',
    programme: '', // Fallback to 'Unknown' if displayName is null
    // Initialize other member attributes here based on form values
  );

  // Convert Member object to a Map and save it to Firestore
  await firestore.collection('members').doc(user.uid).set(newMember.toJson());
}

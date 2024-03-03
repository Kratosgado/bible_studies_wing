


// Future saveFormData(User user) async {
//   final firestore = FirebaseFirestore.instance;

//   Member newMember = Member(
//     id: user.uid,
//     name: user.displayName ?? 'Unknown',
//     photoUrl: user.photoURL ?? '',
//     birthdate: DateTime(4),
//     contact: user.phoneNumber ?? '',
//     executive: false,
//     hall: '',
//     programme: '', // Fallback to 'Unknown' if displayName is null
//     // Initialize other member attributes here based on form values
//   );

//   // Convert Member object to a Map and save it to Firestore
//   await firestore.collection('members').doc(user.uid).set(newMember.toJson());
// }

import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AppPreferences {
  final GetStorage storage = GetStorage();
  AppPreferences();

  Future<bool> isUserLoggedIn() async {
    return storage.read('isUserLoggedIn') ?? false;
  }

  Future<void> setCurrentMember(Member member) async {
    await storage.write('currentMember', member.toJson());
  }

  Member getCurrentMember() {
    final member = storage.read('currentMember');
    return Member.fromJson(member);
  }

  Future<void> login() async {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    // Get member data from firestore
    final getCurrentUser =
        await FirebaseFirestore.instance.collection('members').doc(currentUserUid).get();
    final member = Member.fromJson(getCurrentUser.data()!);
    await setCurrentMember(member);

    await storage.write('isUserLoggedIn', true);
  }

  Future<void> logout() async {
    await storage.write('isUserLoggedIn', false);
  }
}

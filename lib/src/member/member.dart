import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  final String id;
  final String photoUrl;
  final String name;
  final DateTime birthdate;
  final String contact;
  final String programme;
  final String hall;
  final bool executive;

  Member({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.birthdate,
    required this.contact,
    required this.programme,
    required this.hall,
    required this.executive,
  });

  // Method to convert Member object to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'birthdate': Timestamp.fromDate(birthdate),
      'contact': contact,
      'programme': programme,
      'hall': hall,
      'executive': executive,
    };
  }

  // Static method to convert Firestore data to Member object
  static Member fromMap(String id, Map<String, dynamic> data) {
    return Member(
      id: id,
      name: data['name'],
      photoUrl: data['photoUrl'],
      birthdate: (data['birthdate'] as Timestamp).toDate(),
      contact: data['contact'],
      programme: data['programme'],
      hall: data['hall'],
      executive: data['executive'],
    );
  }
}

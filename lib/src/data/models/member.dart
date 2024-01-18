import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()

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
  Map<String, dynamic> toJson()  => _$MemberToJson(this);
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}

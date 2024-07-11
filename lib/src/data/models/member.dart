import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  final String id;
  final String photoUrl;
  final String name;
  final String birthdate;
  final String contact;
  final String programme;
  final String? hall;
  final String? executivePosition;
  final int? year;

  Member({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.birthdate,
    required this.contact,
    required this.programme,
    this.hall,
    this.executivePosition,
    this.year,
  });

  // Method to convert Member object to a Map (for Firestore)
  Map<String, dynamic> toJson({bool convert = true}) => _$MemberToJson(this, convert);
  factory Member.fromJson(Map<String, dynamic> json, {converted = false}) =>
      _$MemberFromJson(json, converted);
}

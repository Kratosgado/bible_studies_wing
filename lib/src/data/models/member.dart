import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'member.g.dart';

@JsonSerializable()

class Member {
  final String id;
  final String photoUrl;
  final String name;
  @TimestampConverter()
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


class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date);
  }
}
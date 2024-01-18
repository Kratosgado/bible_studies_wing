// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['id'] as String,
      photoUrl: json['photoUrl'] as String,
      name: json['name'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
      contact: json['contact'] as String,
      programme: json['programme'] as String,
      hall: json['hall'] as String,
      executive: json['executive'] as bool,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'name': instance.name,
      'birthdate': instance.birthdate.toIso8601String(),
      'contact': instance.contact,
      'programme': instance.programme,
      'hall': instance.hall,
      'executive': instance.executive,
    };

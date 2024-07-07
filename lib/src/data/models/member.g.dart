// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json, bool converted) => Member(
      id: json['id'] as String,
      photoUrl: json['photoUrl'] as String,
      name: json['name'] as String,
      birthdate:json['birthdate'],
      contact: json['contact'] as String,
      programme: json['programme'] as String,
      hall: json['hall'] != null ? json['hall'] as String : null,
      year: json['year'] != null ? json["year"] as int : null,
      executivePosition: json['executivePosition'] != null ? json['executivePosition'] as String : null,
    );

Map<String, dynamic> _$MemberToJson(Member instance, bool convert) => <String, dynamic>{
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'name': instance.name,
      'birthdate': convert
          ? (instance.birthdate)
          : instance.birthdate.toString(),
      'contact': instance.contact,
      'programme': instance.programme,
      'hall': instance.hall,
      'year': instance.year,
      'executivePosition': instance.executivePosition,
    };

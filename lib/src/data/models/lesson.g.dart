// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      comment: json['comment'] as String,
      username: json['username'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'username': instance.username,
      'photoUrl': instance.photoUrl,
      'comment': instance.comment,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as String,
      topic: json['topic'] as String,
      subtopic: json['subtopic'] as String,
      body: json['body'] as List<dynamic>,
      imageUrl: json['imageUrl'] as String,
      date: dateTimeFromTimestamp(json['date'] as Timestamp),

    )..comments = json['comments'] != null ? (json['comments'] as List<dynamic>)
        .map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList() : null;

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'subtopic': instance.subtopic,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'date': dateTimeAsIs(instance.date),
      'comments': instance.comments,
    };

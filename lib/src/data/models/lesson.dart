import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Comment {
  final String id;
  final String userId;
  final String username;
  final String photoUrl;
  final String comment;

  Comment({
    required this.id,
    required this.userId,
    required this.comment,
    required this.username,
    required this.photoUrl,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class Lesson {
  final String id;
  final String topic;
  final String subtopic;
  final String anchorScripture;
  final List<String> verses;
  final List<dynamic> body;
  final String imageUrl;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeAsIs)
  final DateTime date;
  final List<Comment> comments = [];

  Lesson({
    required this.id,
    required this.topic,
    required this.subtopic,
    required this.anchorScripture,
    required this.verses,
    required this.body,
    required this.imageUrl,
    required this.date,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);

  Future<List<Comment>> getComments() async {
    try {
      final commentsSnapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(id)
          .collection('comments')
          .get();

      final comments = commentsSnapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList();

      return comments;
    } catch (e) {
      debugPrint('Error getting comments: $e');
      return [];
    }
  }

  Future<void> saveComment(Comment comment) async {
    try {
      await FirebaseFirestore.instance
          .collection('lessons')
          .doc(id)
          .collection('comments')
          .doc(comment.id) // Use the comment's id as the document id in the subcollection
          .set(comment.toJson());
      await getComments();
    } catch (e) {
      debugPrint('Error saving comment: $e');
    }
  }

  String formatDate() {
    String month = switch (date.month) {
      DateTime.january => "January",
      DateTime.february => "February",
      DateTime.march => "March",
      DateTime.april => "April",
      DateTime.may => "May",
      DateTime.june => "June",
      DateTime.july => "July",
      DateTime.august => "August",
      DateTime.september => "September",
      DateTime.october => "October",
      DateTime.november => "November",
      DateTime.december => "December",
      _ => "",
    };

    return "$month ${date.day}, ${date.year}";
  }
}

DateTime dateTimeFromTimestamp(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

DateTime dateTimeAsIs(DateTime dateTime) => dateTime;

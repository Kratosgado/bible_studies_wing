import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}

class Lesson {
  final String id;
  final String topic;
  final String subtopic;
  final String anchorScripture;
  final List<String> verses;
  final List<dynamic> body;
  final String imageUrl;
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

  // Method to convert Lesson object to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'topic': topic,
      'subtopic': subtopic,
      'anchorScripture': anchorScripture,
      'verses': verses,
      'body': body,
      'imageUrl': imageUrl,
      'date': Timestamp.fromDate(date),
    };
  }

  // Static method to convert Firestore data to Lesson object
  static Lesson fromMap(String id, Map<String, dynamic> data) {
    return Lesson(
      id: id,
      topic: data['topic'],
      subtopic: data['subtopic'],
      anchorScripture: data['anchorScripture'],
      verses: List<String>.from(data['verses']),
      body: data['body'],
      imageUrl: data['imageUrl'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Future<List<Comment>> getComments() async {
    try {
      final commentsSnapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(id)
          .collection('comments')
          .get();

      final comments = commentsSnapshot.docs.map((doc) {
        return Comment(
          id: doc.id,
          userId: doc.data()['userId'],
          username: doc.data()['username'],
          photoUrl: doc.data()['photoUrl'],
          comment: doc.data()['comment'],
        );
      }).toList();

      return comments;
    } catch (e) {
      debugPrint('Error getting comments: $e');
      return [];
    }
  }

  Future<void> saveComment(Comment comment) async {
    try {
      final commentData = {
        'userId': comment.userId,
        'comment': comment.comment,
        'username': comment.username,
        'photoUrl': comment.photoUrl,
      };

      await FirebaseFirestore.instance
          .collection('lessons')
          .doc(id)
          .collection('comments')
          .doc(comment.id) // Use the comment's id as the document id in the subcollection
          .set(commentData);
      await getComments();
    } catch (e) {
      debugPrint('Error saving comment: $e');
    }
  }
}

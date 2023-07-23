import 'package:cloud_firestore/cloud_firestore.dart';

class LessonInfo {
  final String id;
  final String topic;
  final String subtopic;
  final String anchorScripture;
  final List<String> verses;
  final String body;
  final String imageUrl;
  final DateTime date;

  LessonInfo({
    required this.id,
    required this.topic,
    required this.subtopic,
    required this.anchorScripture,
    required this.verses,
    required this.body,
    required this.imageUrl,
    required this.date,
  });

  // Method to convert LessonInfo object to a Map (for Firestore)
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

  // Static method to convert Firestore data to LessonInfo object
  static LessonInfo fromMap(String id, Map<String, dynamic> data) {
    return LessonInfo(
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
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TodayEventScreen extends StatelessWidget {
  const TodayEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Today\'s Event')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').limitToLast(1).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          if (snapshot.data!.docs.isEmpty) return const Center(child: Text('No events today.'));
          var event = snapshot.data?.docs[0];
          final doc = Document.fromJson(event?['body']);
          return Column(
            children: [
              CachedNetworkImage(imageUrl: event?['image']),
              Expanded(
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: QuillController(
                        document: doc, selection: const TextSelection.collapsed(offset: 0)),
                    readOnly: true,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

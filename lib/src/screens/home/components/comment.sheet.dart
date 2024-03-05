import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/lesson.dart';

void showCommentSheet(BuildContext context, Lesson lesson, currentUserProfile) {
  final commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> deleteComment(String id) async {
    await FirebaseFirestore.instance
        .collection("lessons")
        .doc(lesson.id)
        .collection("comments")
        .doc(id)
        .delete();
  }

  showModalBottomSheet(
    elevation: 20,
    showDragHandle: true,
    useSafeArea: true,
    enableDrag: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('lessons')
                    .doc(lesson.id)
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No comment yet"),
                    );
                  }
                  final comments =
                      snapshot.data!.docs.map((doc) => Comment.fromJson(doc.data())).toList();
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(comment.photoUrl),
                        ),
                        title: Text(comment.username),
                        subtitle: Text(comment.comment),
                        trailing: AppService.currentMember.id == currentUser.uid
                            ? IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                onPressed: () async => deleteComment(comment.id),
                              )
                            : null,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    currentUserProfile,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    // give a rounded input decoration
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      hintText: 'Add a question/comment',
                    ),
                    // Add any logic to save the user's input here
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // lesson.saveComment();

                    final newComment = Comment(
                      id: const Uuid().v1(),
                      userId: currentUser.uid,
                      comment: commentController.text,
                      username: currentUser.displayName!,
                      photoUrl: currentUser.photoURL!,
                    );

                    lesson.saveComment(newComment);
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

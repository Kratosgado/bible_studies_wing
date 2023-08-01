import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../lesson/lesson.dart';

void showCommentSheet(BuildContext context, Lesson lesson, currentUserProfile) {
  final commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

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
              child: ListView.builder(
                itemCount: lesson.comments.length,
                itemBuilder: (context, index) {
                  final comment = lesson.comments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(comment.photoUrl),
                    ),
                    title: Text(comment.username),
                    subtitle: Text(comment.comment),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(currentUserProfile),
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
                    // Add any logic to save the comment and close the bottom sheet here
                    Navigator.pop(context); // Close the bottom sheet
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

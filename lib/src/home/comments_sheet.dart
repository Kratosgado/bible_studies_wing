import 'package:flutter/material.dart';

import '../lesson/lesson.dart';

void showCommentSheet(BuildContext context, Lesson lesson) {
  final commentController = TextEditingController();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: lesson.comments.length,
                itemBuilder: (context, index) {
                  final comment = lesson.comments[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(
                          'path/to/profile_image.png'), // Replace with the actual profile image
                    ),
                    title: Text(comment.userId),
                    subtitle: Text(comment.comment),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                      'path/to/profile_image.png'), // Replace with the actual profile image of the current user
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    decoration: const InputDecoration(labelText: 'Add a comment'),
                    // Add any logic to save the user's input here
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // lesson.saveComment();
                    // Add any logic to save the comment and close the bottom sheet here
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

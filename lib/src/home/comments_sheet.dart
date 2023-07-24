import 'package:flutter/material.dart';

void showCommentSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add the content of the bottom sheet here
            const Text(
              'This is the bottom sheet content.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add any actions you want to perform when the button is pressed
                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

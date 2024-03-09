import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/lesson.dart';

void showCommentSheet(BuildContext context, Lesson lesson) {
  final commentController = TextEditingController();
  final currentMember = AppService.currentMember;

  Future<void> deleteComment(String id) async {
    debugPrint("Deleting comment");
    try {
      await FirebaseFirestore.instance
          .collection("lessons")
          .doc(lesson.id)
          .collection("comments")
          .doc(id)
          .delete()
          .then((_) => Get.snackbar(
                "Comment deleted",
                "Comment deleted successfully",
                colorText: Colors.white,
                backgroundColor: ColorManager.deepBblue,
              ));
    } catch (e) {
      debugPrint("Error deleting comment: $e");
      Get.snackbar(
        "Error",
        "Error deleting comment",
        colorText: Colors.white,
        backgroundColor: ColorManager.deepBblue,
      );
    }
  }

  showModalBottomSheet(
    elevation: 20,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    enableDrag: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
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
                          trailing: AppService.currentMember.id == currentMember.id
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
                      currentMember.photoUrl,
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
                        userId: currentMember.id,
                        comment: commentController.text,
                        username: currentMember.name,
                        photoUrl: currentMember.photoUrl,
                      );

                      lesson.saveComment(newComment);
                      commentController.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

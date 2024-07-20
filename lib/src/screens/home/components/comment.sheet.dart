import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/lesson.dart';

void showCommentSheet(BuildContext context, Lesson lesson) {
  final commentController = TextEditingController();
  final currentMember = AppService.currentMember!;

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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: ColorManager.deepBblue,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Spacing.s28), topRight: Radius.circular(Spacing.s28)),
          ),
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
                        child: Text(
                          "No comment yet",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    final comments =
                        snapshot.data!.docs.map((doc) => Comment.fromJson(doc.data())).toList();
                    return ListView.separated(
                      itemCount: comments.length,
                      separatorBuilder: (context, index) => Divider(
                        color: ColorManager.faintWhite,
                        indent: 50,
                        endIndent: 50,
                      ),
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          leading: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(comment.photoUrl),
                          ),
                          title: Text(
                            comment.username,
                            style: const TextStyle(
                              fontSize: Spacing.s15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            comment.comment,
                            style: TextStyle(
                              fontSize: Spacing.s15,
                              color: ColorManager.faintWhite,
                            ),
                          ),
                          trailing: AppService.currentMember!.id == comment.userId
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
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
              TextFormField(
                controller: commentController,
                style: context.textTheme.bodyMedium?.copyWith(color: Colors.black),
                // give a rounded input decoration
                decoration: InputDecoration(
                  icon: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      currentMember.photoUrl,
                    ),
                  ),
                  hintText: 'Add a question/comment',
                  suffixIcon: IconButton(
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
                    icon: Icon(
                      Icons.send,
                      color: ColorManager.deepBblue,
                      size: Spacing.s28,
                    ),
                  ),
                ),
                // Add any logic to save the user's input here
              ),
            ],
          ),
        ),
      );
    },
  );
}

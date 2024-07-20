import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AddAnnouncementScreen extends StatelessWidget {
  final QuillController _controller = QuillController.basic();

  AddAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: CurvedScaffold(
        title: 'Add Announcement',
        floatingActionButton: FloatingActionButton(
          onPressed: uploadAnnouncement,
          child: const Icon(Icons.save),
        ),
        bottomNavigationBar: QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            controller: _controller,
            multiRowsDisplay: false,
          ),
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.s8, vertical: Spacing.s16),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: _controller,
                    autoFocus: true,
                    // readOnly: false,
                    customStyles: DefaultStyles(
                      paragraph: DefaultTextBlockStyle(
                        TextStyle(
                          color: ColorManager.deepBblue,
                          fontSize: 18,
                        ),
                        const VerticalSpacing(1.0, 1),
                        const VerticalSpacing(1.0, 1),
                        const BoxDecoration(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadAnnouncement() async {
    await AppService.showLoadingPopup(
      asyncFunction: () async {
        FirebaseFirestore.instance
            .collection('once')
            .doc("announcement")
            .set({
              'date': DateTime.now().toString(),
              'body': _controller.document.toDelta().toJson(),
            })
            .then((_) async => {
                  await AppService.notificationService.sendMessageToTopic(
                      message: "New announcement",
                      topic: AppService.announcementTopic,
                      title: "New Lesson"),
                })
            .catchError((err) => err);
      },
      message: "Updating announcement",
      errorMessage: "Failed to update announcement",
      callback: () => Get.offNamed(Routes.announcementRoute),
    );
  }
}

import 'dart:io';

import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:cached_network_image/cached_network_image.dart';

List<QueryDocumentSnapshot<Object?>>? imageUrls = [];

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
        title: 'Gallery',
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            // select multiple images and upload to firestore
            final picker = ImagePicker();
            final pickedFile = await picker.pickMultiImage();
            if (pickedFile.isNotEmpty) {
              for (var image in pickedFile) {
                var file = File(image.path);
                var ref = FirebaseStorage.instance.ref().child(image.path);
                await ref.putFile(file);
                var url = await ref.getDownloadURL();
                await FirebaseFirestore.instance.collection('gallery').add({'url': url});
              }
            }
          },
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('gallery').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            imageUrls = snapshot.data?.docs;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: Spacing.s5,
                crossAxisSpacing: Spacing.s5,
              ),
              itemCount: imageUrls?.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrls?[index]["url"];
                return Hero(
                  tag: imageUrl,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageScreen(
                                  index: index,
                                ))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Spacing.s10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

class ImageScreen extends StatelessWidget {
  final int index;

  const ImageScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: imageUrls?.length,
        controller: PageController(initialPage: index),
        itemBuilder: (_, idx) {
          final url = imageUrls?[idx]["url"];
          final id = imageUrls?[idx].id;
          return CurvedScaffold(
            title: 'Image',
            action: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () async {
                await AppService.showLoadingPopup(
                    asyncFunction: () async {
                      await FirebaseFirestore.instance.collection("gallery").doc(id).delete();
                      await FirebaseStorage.instance.refFromURL(url).delete();
                    },
                    message: "deleting picture",
                    errorMessage: "Failed to delete picture",
                    callback: () => Get.back());
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorManager.faintWhite,
              child: const Icon(
                Icons.download,
                color: Colors.white,
              ),
              onPressed: () async {
                var ref = FirebaseStorage.instance.refFromURL(url);
                var bytes = await ref.getData();
                var downloadDir = Directory("/storage/emulated/0/Download");
                File file = File('${downloadDir.path}/${ref.name}.jpg');
                await file.writeAsBytes(bytes!);
                Get.snackbar('Download', 'Image downloaded');
              },
            ),
            child: InteractiveViewer(
              child: ColoredBox(
                color: Colors.black,
                child: Center(
                  child: Hero(
                    tag: url,
                    child: CachedNetworkImage(
                      imageUrl: url,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

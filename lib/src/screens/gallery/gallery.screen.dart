import 'dart:io';

import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:cached_network_image/cached_network_image.dart';

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

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final imageUrl = snapshot.data?.docs[index]['url'] as String;
                return Hero(
                  tag: imageUrl,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ImageScreen(imageUrl))),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      filterQuality: FilterQuality.medium,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
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
  final String url;

  const ImageScreen(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: 'Image',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () async {
          var ref = FirebaseStorage.instance.refFromURL(url);
          var bytes = await ref.getData();
          var dir = await path_provider.getExternalStorageDirectory();
          debugPrint('dir: $dir');
          File file = File('${dir!.path}/${ref.name}.jpg');
          await file.writeAsBytes(bytes!);
          Get.snackbar('Download', 'Image downloaded');
        },
      ),
      child: Center(
        child: Hero(
          tag: url,
          child: CachedNetworkImage(
            imageUrl: url,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}

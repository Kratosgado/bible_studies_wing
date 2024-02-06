import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:cached_network_image/cached_network_image.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('images').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: snapshot.data?.docs[index]['url'],
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageScreen(snapshot.data?.docs[index]['url']))),
                  child: Image.network(snapshot.data?.docs[index]['url']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String url;

  const ImageScreen(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image')),
      body: Center(
        child: Hero(
          tag: url,
          child: Image.network(url),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () async {
          var ref = FirebaseStorage.instance.ref().child(url);
          var bytes = await ref.getData();
          var dir = await path_provider.getApplicationDocumentsDirectory();
          File file = File('${dir.path}/image.jpg');
          await file.writeAsBytes(bytes!);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Image downloaded')));
        },
      ),
    );
  }
}

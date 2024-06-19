import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:get/get.dart';

import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class MemberProfileScreen extends StatelessWidget {
  final Member member = Get.arguments;

  MemberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: member.name,
      // appBar: AppBar(
      //   title: const Text('Member Profile'),
      //   actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      // ),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => AppService.viewPicture(CachedNetworkImage(imageUrl: member.photoUrl), "Display Picture"),
            child: Container(
              height: Spacing.s190,
              // padding: const EdgeInsets.all(Spacing.s5),
              margin: const EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: StyleManager.boxDecoration.copyWith(
                shape: BoxShape.circle,
                borderRadius: null,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black,
                    blurRadius: Spacing.s4,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: Hero(
                tag: 'profile_pic${member.id}',
                child: CircleAvatar(
                    radius: Spacing.s90,
                    backgroundImage: CachedNetworkImageProvider(member.photoUrl)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'ID: ${member.id}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Card(
            color: ColorManager.deepBblue,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Birthdate:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppService.formatDate(member.birthdate), // Format the birthdate as needed
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Contact:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    member.contact,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Programme:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    member.programme,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hall:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    member.hall,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Executive:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    member.executivePosition ?? "Not Executive",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CircleAvatar(
//             radius: 100,
//             backgroundImage: CachedNetworkImageProvider(member.photoUrl),
//           ),
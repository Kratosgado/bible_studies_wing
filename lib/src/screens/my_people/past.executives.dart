import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:bible_studies_wing/src/screens/home/components/list.tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/member.dart';
import '../../resources/values_manager.dart';

class PastExecutivesScreen extends StatelessWidget {
  const PastExecutivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "Past Executives",
      floatingActionButton: AppService.currentMember!.executivePosition != null
          ? FloatingActionButton(
              onPressed: () => Get.toNamed(Routes.addPastExecutivesRoute),
              child: const Icon(Icons.add),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.s20, horizontal: Spacing.s10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('past_executives').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            }

            final data = snapshot.data!;
            final members = data.docs.map((doc) => Member.fromJson(doc.data())).toList();

            return ListView.separated(
                itemBuilder: (context, index) {
                  final member = members[index];
                  return CustomListTile(
                    imageUrl: member.photoUrl,
                    title: member.name,
                    subTitle: member.executivePosition ?? member.programme,
                    callback: () => Get.toNamed(Routes.memberProfileRoute, arguments: member),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: members.length);
          },
        ),
      ),
    );
  }
}

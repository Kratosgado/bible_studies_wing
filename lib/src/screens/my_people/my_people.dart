import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import '../../data/models/member.dart';

class MyPeopleScreen extends StatelessWidget {
  static const routeName = '/myPeople';

  const MyPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My People'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('members').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          final data = snapshot.data!;
          final members = data.docs.map((doc) => Member.fromJson(doc.data())).toList();

          final executives = members.where((member) => member.executive).toList();
          final nonExecutives = members.where((member) => !member.executive).toList();

          return ListView(children: [
            _buildExpandableListTile(
              title: 'Executives',
              children:
                  executives.map((executive) => _buildMemberTile(context, executive)).toList(),
            ),
            _buildExpandableListTile(
              title: 'Non-Executives',
              children: nonExecutives
                  .map((nonExecutives) => _buildMemberTile(context, nonExecutives))
                  .toList(),
            )
          ]);
        },
      ),
    );
  }

  Widget _buildExpandableListTile({
    required String title,
    required List<Widget> children,
  }) {
    return ExpandablePanel(
      collapsed: Center(child: Text("List of all $title members")),
      header: ListTile(
        title:
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        onTap: () {}, // You can add any desired behavior when the header is tapped
      ),
      expanded: Column(
        children: children,
      ),
    );
  }

  Widget _buildMemberTile(BuildContext context, Member member) {
    return ListTile(
      textColor: Colors.black,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(member.photoUrl),
      ),
      title: Text(member.name),
      subtitle: Text(member.programme),
      trailing: member.executive
          ? const Icon(
              Icons.star,
              color: Colors.blueAccent,
            )
          : null,
      onTap: () {
        Get.toNamed(Routes.memberProfileRoute, arguments: member);
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => MemberProfileScreen(
        //       member: member,
        //     ),
        //   ),
        // );
      },
    );
  }
}

import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:get/get.dart';

class MemberProfileScreen extends StatelessWidget {
  final Member member = Get.arguments;

  MemberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedScaffold(
      title: "Member Profile",
      // appBar: AppBar(
      //   title: const Text('Member Profile'),
      //   actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      // ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(member.photoUrl),
              ),
              const SizedBox(height: 20),
              Text(
                member.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'ID: ${member.id}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Card(
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
                        member.birthdate.toString(), // Format the birthdate as needed
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
                        member.executive ? 'Yes' : 'No',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

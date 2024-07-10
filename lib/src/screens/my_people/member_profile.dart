import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bible_studies_wing/src/data/models/member.dart';
import 'package:get/get.dart';

import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class MemberProfileScreen extends StatefulWidget {
  const MemberProfileScreen({super.key});

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  final Member member = Get.arguments;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _contactController = TextEditingController();
  final _programmeController = TextEditingController();
  final _hallController = TextEditingController();
  final _yearController = TextEditingController();
  final _executivePosition = TextEditingController();

  bool changed = false;

  @override
  void initState() {
    _contactController.text = member.contact;
    _programmeController.text = member.programme;
    _hallController.text = member.hall ?? "";
    _nameController.text = member.name;
    _birthdateController.text = member.birthdate;
    _executivePosition.text = member.executivePosition ?? "";
    _yearController.text = member.year.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.textTheme.titleMedium;
    final valueStyle = context.textTheme.bodyMedium;
    return CurvedScaffold(
      title: member.name,
      floatingActionButton: (AppService.currentMember!.id == member.id ||
              AppService.currentMember!.executivePosition != null)
          ? FloatingActionButton.extended(onPressed: () {}, label: const Text("Save Changes"))
          : null,
      // appBar: AppBar(
      //   title: const Text('Member Profile'),
      //   actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      // ),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s20),
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => AppService.viewPicture(CachedNetworkImage(imageUrl: member.photoUrl),
                  "Display Picture", member.photoUrl),
              child: Container(
                height: Spacing.s190,
                // padding: const EdgeInsets.all(Spacing.s5),
                margin: const EdgeInsets.all(3),
                alignment: Alignment.center,
                decoration: StyleManager.boxDecoration.copyWith(
                  shape: BoxShape.circle,
                  // boxShadow: [
                  //   const BoxShadow(
                  //     color: Colors.black,
                  //     blurRadius: Spacing.s4,
                  //     offset: Offset(2, 2),
                  //   )
                  // ],
                ),
                child: Hero(
                  tag: member.photoUrl,
                  child: CircleAvatar(
                      radius: Spacing.s90,
                      backgroundImage: CachedNetworkImageProvider(member.photoUrl)),
                ),
              ),
            ),
            const SizedBox(height: Spacing.s16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(suffixText: "Name", suffixStyle: titleStyle),
              style: valueStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: Spacing.s16),
            TextFormField(
              controller: _birthdateController,
              readOnly: true,
              style: valueStyle,
              onTap: () async {
                _birthdateController.text = await AppService.selectDate(context) ?? "Select Date";
              },
              decoration: InputDecoration(suffixText: "Birthday", suffixStyle: titleStyle),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a birthdate';
                }
                return null;
              },
            ),
            const SizedBox(height: Spacing.s16),
            TextFormField(
              controller: _contactController,
              keyboardType: TextInputType.phone,
              style: valueStyle,
              decoration: InputDecoration(suffixText: "Contact", suffixStyle: titleStyle),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
            ),
            const SizedBox(height: Spacing.s16),
            TextFormField(
              controller: _programmeController,
              style: valueStyle,
              decoration: InputDecoration(suffixText: "Programme", suffixStyle: titleStyle),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
            ),
            const SizedBox(height: Spacing.s16),
            TextFormField(
              controller: member.hall != null ? _hallController : _yearController,
              style: valueStyle,
              decoration: InputDecoration(
                  suffixText: member.hall != null ? "Hall" : "Year", suffixStyle: titleStyle),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                } else if (int.parse(value).isLowerThan(2000)) {
                  return "Expecing a number greater than 2000";
                }
                return null;
              },
            ),
            const SizedBox(height: Spacing.s16),
            TextFormField(
              controller: _executivePosition,
              style: valueStyle,
              decoration:
                  InputDecoration(suffixText: "Executive Position", suffixStyle: titleStyle),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    await AppService.showLoadingPopup(
      asyncFunction: () async {
        if (_formKey.currentState!.validate()) {
          final firestore = FirebaseFirestore.instance;
          // if (_imageFile != null) {
          //   final Reference storageRef = FirebaseStorage.instance
          //       .ref()
          //       .child('profile_images')
          //       .child('${id.toString()}.jpg');

          //   final UploadTask uploadTask = storageRef.putFile(_imageFile!);

          // final TaskSnapshot storageSnapshot = await uploadTask;
          // final String photoUrl = await storageSnapshot.ref.getDownloadURL();
          Member newMember = Member(
            id: member.id,
            name: _nameController.text,
            photoUrl: member.photoUrl, // will be back
            birthdate: _birthdateController.text,
            contact: _contactController.text,
            programme: _programmeController.text,
            year: int.parse(_yearController.text),
            executivePosition: _executivePosition.text,
          );
          // Convert Member object to a Map and save it to Firestore
          await firestore
              .collection('past_executives')
              .doc(member.id)
              .set(newMember.toJson(), SetOptions(merge: true));
        } else {
          Get.snackbar("Registration Error", "Add a profile picture to continue",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      },
      message: "Submitting information",
      errorMessage: "Error submitting information",
      callback: () {},
    );
  }
}

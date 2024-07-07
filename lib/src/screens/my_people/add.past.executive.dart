import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Add this line
import 'dart:io'; // Add this line
import 'package:firebase_storage/firebase_storage.dart'; // Add this line
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import '../../data/models/member.dart';

class AddPastExecutiveScreen extends StatefulWidget {
  const AddPastExecutiveScreen({super.key});

  @override
  MemberRegistrationFormState createState() => MemberRegistrationFormState();
}

class MemberRegistrationFormState extends State<AddPastExecutiveScreen> {
  final currentUser = AppService.currentMember;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _contactController = TextEditingController();
  final _programmeController = TextEditingController();
  final _yearController = TextEditingController();
  final _executivePosition = TextEditingController();
  bool executiveStatus = false;

  @override
  void dispose() {
    _nameController.dispose();
    _birthdateController.dispose();
    _contactController.dispose();
    _programmeController.dispose();
    super.dispose();
  }

  File? _imageFile; // For storing the selected image

  // Method to handle selecting an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: CurvedScaffold(
        title: "Member Registration Form",
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _imageFile != null
                    ? CircleAvatar(
                        radius: Spacing.s100,
                        backgroundImage: FileImage(_imageFile!),
                      ) // Show the selected image if available
                    : const SizedBox.shrink(),
                Center(
                  child: ElevatedButton(
                    onPressed: _pickImage, // Call the _pickImage method when the button is pressed
                    child: const Text('Select Image'),
                  ),
                ),
                // Otherwise, hide the Image widget
                const SizedBox(height: Spacing.s16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
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
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
                  onTap: () async {
                    _birthdateController.text =
                        await AppService.selectDate(context) ?? "Select date";
                  },
                  decoration: const InputDecoration(labelText: 'Birthdate'),
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
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
                  decoration: const InputDecoration(labelText: 'Contact'),
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
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
                  decoration: const InputDecoration(labelText: 'Programme'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Spacing.s16),
                TextFormField(
                  controller: _yearController,
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
                  decoration: const InputDecoration(labelText: 'Year'),
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
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
                  decoration: const InputDecoration(labelText: 'Executive Position'),
                ),
                const SizedBox(height: Spacing.s16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Save the form data to Firestore
                      _saveFormData();
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveFormData() async {
    final id = const Uuid().v4();
    await AppService.showLoadingPopup(
        asyncFunction: () async {
          if (_formKey.currentState!.validate()) {
            final firestore = FirebaseFirestore.instance;
            if (_imageFile != null) {
              final Reference storageRef = FirebaseStorage.instance
                  .ref()
                  .child('profile_images')
                  .child('${id.toString()}.jpg');

              final UploadTask uploadTask = storageRef.putFile(_imageFile!);

              final TaskSnapshot storageSnapshot = await uploadTask;
              final String photoUrl = await storageSnapshot.ref.getDownloadURL();
              Member newMember = Member(
                id: id.toString(),
                name: _nameController.text,
                photoUrl: photoUrl, // will be back
                birthdate: _birthdateController.text,
                contact: _contactController.text,
                programme: _programmeController.text,
                year: int.parse(_yearController.text),
                executivePosition: _executivePosition.text,
              );
              // Convert Member object to a Map and save it to Firestore
              await firestore
                  .collection('past_executives')
                  .doc(id.toString())
                  .set(newMember.toJson());
            } else {
              Get.snackbar("Registration Error", "Add a profile picture to continue",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          }
        },
        message: "Submitting information",
        errorMessage: "Error submitting information");
  }
}

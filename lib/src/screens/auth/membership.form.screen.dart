import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:bible_studies_wing/src/resources/color_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/resources/values_manager.dart';
import 'package:bible_studies_wing/src/screens/home/components/curved.scaffold.dart';
import 'package:bible_studies_wing/src/screens/home/components/input.field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Add this line
import 'dart:io'; // Add this line
import 'package:firebase_storage/firebase_storage.dart'; // Add this line
import '../../data/models/member.dart';
import '../../resources/styles_manager.dart';

class MemberRegistrationForm extends StatefulWidget {
  final User user = Get.arguments; // Receive user data as an argument

  MemberRegistrationForm({super.key});

  @override
  MemberRegistrationFormState createState() => MemberRegistrationFormState();
}

class MemberRegistrationFormState extends State<MemberRegistrationForm> {
  // final auth = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _contactController = TextEditingController();
  final _programmeController = TextEditingController();
  final _hallController = TextEditingController();
  final _verifierController = TextEditingController();
  final _executivePosition = TextEditingController();
  bool executiveStatus = false;

  bool _isExecutive = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.displayName!;
    // Initialize other form fields with user data if available
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdateController.dispose();
    _contactController.dispose();
    _programmeController.dispose();
    _hallController.dispose();
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
                    ? Container(
                        height: Spacing.s190,
                        // padding: const EdgeInsets.all(Spacing.s5),
                        margin: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        decoration: StyleManager.boxDecoration.copyWith(
                          shape: BoxShape.circle,
                        ),
                        child: Hero(
                          tag: "registrationProfile",
                          child: CircleAvatar(
                            radius: Spacing.s90,
                            backgroundImage: FileImage(_imageFile!),
                          ),
                        ),
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
                InputField(
                  label: "test",
                  controller: _programmeController,
                ),
                const SizedBox(height: Spacing.s16),

                TextFormField(
                  controller: _birthdateController,
                  readOnly: true,
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
                  onTap: () async {
                    _birthdateController.text =
                        await AppService.selectDate(context) ?? "Select Date";
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _hallController,
                  style: Theme.of(context).primaryTextTheme.bodyLarge!,
                  decoration: const InputDecoration(labelText: 'Hall/Hostel'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isExecutive,
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      fillColor: WidgetStateColor.resolveWith((states) => ColorManager.deepBblue),
                      overlayColor: WidgetStateColor.resolveWith((states) => Colors.white),
                      onChanged: (value) {
                        setState(() {
                          _isExecutive = value ?? false;
                          if (!_isExecutive) {
                            _verifierController.clear();
                          }
                        });
                      },
                    ),
                    Text(
                      'Executive',
                      style: TextStyle(color: ColorManager.deepBblue),
                    ),
                  ],
                ),
                if (_isExecutive)
                  TextFormField(
                    controller: _verifierController,
                    style: Theme.of(context).primaryTextTheme.bodyLarge!,
                    onChanged: (value) => {
                      setState(() {
                        executiveStatus =
                            (int.tryParse(value) != AppService.passcode) ? false : true;
                      })
                    },
                    decoration: const InputDecoration(labelText: 'Verifier Code'),
                    validator: (value) {
                      // Add your verifier code validation logic here
                      if (int.parse(value!) != AppService.passcode) {
                        executiveStatus = false;
                        return 'Incorrect code';
                      }
                      executiveStatus = true;
                      return null; // Validation passes, return null.
                    },
                  ),
                const SizedBox(height: Spacing.s16),

                if (executiveStatus)
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
    await AppService.showLoadingPopup(
      asyncFunction: () async {
        if (_formKey.currentState!.validate()) {
          final firestore = FirebaseFirestore.instance;
          if (_imageFile != null) {
            final Reference storageRef = FirebaseStorage.instance
                .ref()
                .child('profile_images')
                .child('${widget.user.uid}.jpg');

            final UploadTask uploadTask = storageRef.putFile(_imageFile!);

            final TaskSnapshot storageSnapshot = await uploadTask;
            final String photoUrl = await storageSnapshot.ref.getDownloadURL();
            Member newMember = Member(
              id: widget.user.uid,
              name: _nameController.text,
              photoUrl: photoUrl, // will be back
              birthdate: _birthdateController.text,
              contact: _contactController.text,
              programme: _programmeController.text,
              hall: _hallController.text,
              executivePosition: _executivePosition.text,
            );
            // Convert Member object to a Map and save it to Firestore
            await firestore
                .collection('members')
                .doc(widget.user.uid)
                .set(newMember.toJson())
                .then((_) => AppService.preferences.login())
                .then((_) async => await Get.put(AppService()).init());
            // Dismiss the loading dialog
            if (mounted) {
              AppService.dismissPopup(context);
            }
          } else {
            Get.snackbar("Registration Error", "Add a profile picture to continue",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        }
      },
      message: "Submitting information",
      errorMessage: "Error submitting information",
      callback: () => Get.offNamed(Routes.homeRoute),
    );
  }
}

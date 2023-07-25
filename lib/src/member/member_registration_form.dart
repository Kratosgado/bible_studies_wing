import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Add this line
import 'dart:io'; // Add this line
import 'package:firebase_storage/firebase_storage.dart'; // Add this line

import 'member.dart';
import 'member_profile.dart';

class MemberRegistrationForm extends StatefulWidget {
  final User user; // Receive user data as an argument

  const MemberRegistrationForm({super.key, required this.user});

  @override
  MemberRegistrationFormState createState() => MemberRegistrationFormState();
}

class MemberRegistrationFormState extends State<MemberRegistrationForm> {
  final auth = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _contactController = TextEditingController();
  final _programmeController = TextEditingController();
  final _hallController = TextEditingController();
  final _verifierController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Member Registration Form')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          height: 200,
                          width: 200,
                        ) // Show the selected image if available
                      : const SizedBox.shrink(),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _pickImage, // Call the _pickImage method when the button is pressed
                    child: const Text('Select Image'),
                  ),
                ),
                // Otherwise, hide the Image widget
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _birthdateController,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  decoration: const InputDecoration(labelText: 'Birthdate'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a birthdate';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Contact'),
                  validator: (value) {
                    // Add your contact validation logic here
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _programmeController,
                  decoration: const InputDecoration(labelText: 'Programme'),
                  validator: (value) {
                    // Add your programme validation logic here
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _hallController,
                  decoration: const InputDecoration(labelText: 'Hall/Hostel'),
                  validator: (value) {
                    // Add your hall validation logic here
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isExecutive,
                      onChanged: (value) {
                        setState(() {
                          _isExecutive = value ?? false;
                          if (!_isExecutive) {
                            _verifierController.clear();
                          }
                        });
                      },
                    ),
                    const Text('Executive'),
                  ],
                ),
                if (_isExecutive)
                  TextFormField(
                    controller: _verifierController,
                    decoration: const InputDecoration(labelText: 'Verifier Code'),
                    validator: (value) {
                      // Add your verifier code validation logic here
                      if (value != '1234') {
                        executiveStatus = false;
                        return 'Incorrect code';
                      }
                      executiveStatus = true;
                      return null; // Validation passes, return null.
                    },
                  ),

                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save the form data to Firestore
                        _saveFormData();
                      }
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

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _birthdateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _saveFormData() async {
    final firestore = FirebaseFirestore.instance;

    Member newMember = Member(
      id: widget.user.uid,
      name: _nameController.text,
      photoUrl: widget.user.photoURL!, // will be back
      birthdate: DateTime.parse(_birthdateController.text),
      contact: _contactController.text,
      programme: _programmeController.text,
      hall: _hallController.text,
      executive: executiveStatus,
    );

    // Convert Member object to a Map and save it to Firestore
    final memberData = newMember.toMap();

    if (_imageFile != null) {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('profile_images').child('${widget.user.uid}.jpg');

      final UploadTask uploadTask = storageRef.putFile(_imageFile!);

      final TaskSnapshot storageSnapshot = await uploadTask;
      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      memberData['photoUrl'] = downloadUrl;
    }
    await firestore.collection('members').doc(widget.user.uid).set(memberData);

    // Reset form fields after submission
    _nameController.clear();
    _birthdateController.clear();
    _contactController.clear();
    _programmeController.clear();
    _hallController.clear();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MemberProfileScreen(
            member: newMember,
          ),
        ),
      );
    }
  }
}

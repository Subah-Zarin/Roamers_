import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'EditItem.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _ProfileState();
}

class _ProfileState extends State<profile> {
  String gender = "man";
  User? loggedInUser;
  String userName = "";
  String age = "" ;
  String userProfileImageUrl = "";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final TextStyle darkTextStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    loggedInUser = FirebaseAuth.instance.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (loggedInUser != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(loggedInUser!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc.data()?['username'] ?? '';
            age = userDoc.data()?['age']?.toString() ?? '';
            gender = userDoc.data()?['gender'] ?? 'man';
            _nameController.text = userName;
            _ageController.text = age;
            userProfileImageUrl = userDoc.data()?['profileImageUrl'] ?? '';
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }
  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Correct usage of File
      File imageFile = File(pickedFile.path); // Ensure dart:io is imported

      String userId = loggedInUser?.uid ?? '';
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('userProfiles/$userId/profile.jpg');
        final uploadTask = storageRef.putFile(imageFile);

        // Show upload progress
        uploadTask.snapshotEvents.listen((taskSnapshot) {
          double progress =
              (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100;
          print('Upload is $progress% complete');
        });

        await uploadTask.whenComplete(() => null);

        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'profileImageUrl': imageUrl,
        });

        setState(() {
          userProfileImageUrl = imageUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully!')),
        );
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }
  Future<void> _updateUserProfile() async {
    if (loggedInUser != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(loggedInUser!.uid).update({
          'username': _nameController.text,
          'age': int.tryParse(_ageController.text) ?? 0,
          'gender': gender,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _updateUserProfile,
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: const Icon(Ionicons.checkmark, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: userProfileImageUrl.isNotEmpty
                          ? NetworkImage(userProfileImageUrl)
                          : AssetImage("assets/images/avatar.jpg") as ImageProvider,
                    ),
                    TextButton(
                      onPressed: _pickAndUploadImage,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: Text(
                        "Upload Image",
                        style: darkTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              EditItem(
                title: "Name",
                widget: TextField(
                  controller: _nameController,
                  style: darkTextStyle,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Gender",
                widget: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "man";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "man"
                            ? Colors.deepPurple
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.male,
                        color: gender == "man" ? Colors.white : Colors.black,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "woman";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "woman"
                            ? Colors.deepPurple
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.female,
                        color: gender == "woman" ? Colors.white : Colors.black,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Age",
                widget: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  style: darkTextStyle,
                  decoration: const InputDecoration(
                    hintText: 'Enter your age',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Email",
                widget: TextField(
                  style: darkTextStyle,
                  decoration: InputDecoration(
                    hintText: loggedInUser?.email ?? '',
                  ),
                  enabled: false, // Make email field read-only
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
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

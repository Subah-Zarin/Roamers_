import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import FirebaseAuth
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ionicons/ionicons.dart';
import 'EditItem.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _ProfileState();
}

class _ProfileState extends State<profile> {
  String gender = "man";
  User? loggedInUser;

  final TextStyle darkTextStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    loggedInUser = FirebaseAuth.instance.currentUser;
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
              onPressed: () {},
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
                    Image.asset(
                      "assets/images/avatar.jpg",
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      onPressed: () {},
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
                  style: darkTextStyle,
                  decoration: InputDecoration(
                    hintText: loggedInUser?.displayName ?? '',
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
                  style: darkTextStyle,
                  decoration: const InputDecoration(),
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

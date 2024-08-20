import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../homepage/homepage.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email validation regex
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  Future<bool> loginUser() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in both email and password',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Validate email format
    if (!emailRegex.hasMatch(email.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    try {
      // Using Firebase Authentication instead of querying Firestore directly
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      if (userCredential.user != null) {
        Get.snackbar(
          'Success',
          'Logged in successfully',
          snackPosition: SnackPosition.TOP,
        );
        Get.to(HomePage());
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Invalid email or password',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      print('Error logging in: $e');
      Get.snackbar(
        'Error',
        'Failed to login: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}

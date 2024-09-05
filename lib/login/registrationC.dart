import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email validation regex
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  Future<void> registerUser() async {
    try {
      if (email.text.isEmpty ||
          username.text.isEmpty ||
          password.text.isEmpty ||
          confirmPassword.text.isEmpty) {
        throw 'Please fill in all fields';
      }

      if (!emailRegex.hasMatch(email.text)) {
        throw 'Invalid email address';
      }

      if (password.text != confirmPassword.text) {
        throw 'Passwords do not match';
      }

      // Use Firebase Authentication to create the user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // If registration is successful, add user details to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email.text,
        'username': username.text,
        'password': password.text,
        // Optionally add more user details here
      });

      Get.snackbar(
        'Success',
        'User registered successfully',
        snackPosition: SnackPosition.TOP,
      );
      Get.toNamed('login');
    } catch (e) {
      print('Failed to register user: $e');
      Get.snackbar(
        'Error',
        'Failed to register user: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onClose() {
    email.dispose();
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}

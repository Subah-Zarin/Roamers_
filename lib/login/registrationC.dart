import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class registrationC extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser() async {
    try {

      if (email.text.isEmpty ||
          username.text.isEmpty ||
          password.text.isEmpty ||
          confirmPassword.text.isEmpty) {
        throw 'Please fill in all fields';
      }


      if (password.text != confirmPassword.text) {
        throw 'Passwords do not match';
      }


      await _firestore.collection('users').add({
        'email': email.text,
        'username': username.text,
        'password': password.text,
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

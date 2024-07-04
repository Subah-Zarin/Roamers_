import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../homepage/homepage.dart';

class loginC extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> loginUser() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in both email and password',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('email', isEqualTo: email.text)
          .where('password', isEqualTo: password.text)
          .get();
      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
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

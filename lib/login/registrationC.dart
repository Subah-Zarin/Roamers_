import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // For Google sign-in

class RegistrationController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Email validation regex
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  // Method to register a user with email and password
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

  // Method to register a user with Google
  Future<void> registerWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the Google sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Use the credential to sign in the user
      UserCredential userCredential = await _auth.signInWithCredential(googleCredential);

      // Store user details in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': googleUser.email,
        'username': googleUser.displayName ?? '',
      });

      Get.snackbar('Success', 'Signed in with Google', snackPosition: SnackPosition.TOP);
      Get.toNamed('homepage'); // Navigate to homepage after successful login
    } catch (e) {
      print('Error during Google sign-in: $e');
      Get.snackbar('Error', 'Failed to sign in with Google: $e', snackPosition: SnackPosition.TOP);
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

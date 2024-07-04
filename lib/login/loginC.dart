import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../homepage/homepage.dart';

class loginC extends GetxController {
   static loginC get instance => Get.find();

   final email = TextEditingController();
   final password = TextEditingController();

   @override
   void onInit() {
      super.onInit();
   }

   Future<void> login() async {
      try {
         await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
         );
         Get.to(HomePage());
      } on FirebaseAuthException catch (e) {
         String errorMessage;
         switch (e.code) {
            case 'wrong-password':
               errorMessage = 'The password is incorrect. Please try again.';
               break;
            case 'user-not-found':
               errorMessage = 'No user found with this email. Please check and try again.';
               break;
            case 'email-already-in-use':
               errorMessage = 'The email is already in use by another account.';
               break;
            case 'invalid-email':
               errorMessage = 'The email address is not valid.';
               break;
            default:
               errorMessage = 'An unknown error occurred. Please try again later.';
               break;
         }
         Get.snackbar("Login Failed", errorMessage);
      }
   }
}

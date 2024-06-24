import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../homepage/homepage.dart';

class loginC extends GetxController {
   TextEditingController mail = TextEditingController();
   TextEditingController password = TextEditingController();

   @override
   void onInit() {
      super.onInit();
   }

   void loginUser() async {
      try {
         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: mail.text.trim(),
            password: password.text.trim(),
         );
         print('User signed in: ${userCredential.user?.email}');
         Get.to(HomePage());
      } on FirebaseAuthException catch (e) {
         if (e.code == 'user-not-found') {
            print('No user found for that email.');
         } else if (e.code == 'wrong-password') {
            print('Wrong password provided.');
         }
      }
   }

   void registerUser() async {
      try {
         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: mail.text.trim(),
            password: password.text.trim(),
         );
         print('User registered: ${userCredential.user?.email}');
         Get.to(HomePage());
      } on FirebaseAuthException catch (e) {
         if (e.code == 'weak-password') {
            print('The password provided is too weak.');
         } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
         }
      }
   }
}

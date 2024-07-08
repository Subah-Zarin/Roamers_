import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roamers/auth/auth_service.dart';
import 'package:roamers/Chat/chat.dart';
import 'package:roamers/login/login.dart';
import '';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        } else if (snapshot.hasData) {
          return ChatPage();
        } else {
          return login();
        }
      },
    );
  }
}

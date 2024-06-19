import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamers/homepage/homepage.dart';
import 'package:roamers/login/login.dart';
import 'package:roamers/login/registration.dart';
import 'package:roamers/welcomePage/welcomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'welcome',
    routes: {
      'welcome': (context) => welcomepage(),
      'login': (context) => login(),
      'register': (context) => registration(),
      'homepage': (context) => HomePage(),
    },
  ));
}


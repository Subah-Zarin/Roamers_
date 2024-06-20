import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamers/firebase_options.dart';
import 'package:roamers/homepage/homepage.dart';
import 'package:roamers/login/login.dart';
import 'package:roamers/login/registration.dart';
import 'package:roamers/welcomePage/welcomepage.dart';

import 'homepage/communitypage.dart';
import 'homepage/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'name here',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'welcome',
    routes: {
      'welcome': (context) => welcomepage(),
      'login': (context) => login(),
      'register': (context) => registration(),
      'homepage': (context) => HomePage(),
      'profile': (context) => profile(),
      'communitypage': (context) => communitypage(),
    },
  ));
}


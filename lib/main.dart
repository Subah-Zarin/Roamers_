import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roamers/welcomePage/welcomepage.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body:welcomepage(),


      ),
    );
  }
}

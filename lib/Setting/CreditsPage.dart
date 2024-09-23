import 'package:flutter/material.dart';

class Creditspage extends StatefulWidget {
  const Creditspage({super.key});

  @override
  _CreditsPageState createState() => _CreditsPageState();
}

class _CreditsPageState extends State<Creditspage> {
  @override
  Widget build(BuildContext context) {
    print("build called: CreditsPage is being built.");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credits Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Credits",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "This app was built with the contributions of the following:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "- Developer: Quazi Zarin Subah"
                  "            "
                  "Roll : 20220204079",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "- Designer: Arpa Adhikary Tathai"
                  "            "
                  "Roll : 20220204094",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "- Project Manager: Zarin Tasnim"
                  "            "
                  "Roll : 20220204096",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "- Special Thanks: Flutter Community",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

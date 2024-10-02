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
        backgroundColor: Colors.indigo, // Same AppBar color as Detailspage
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.lightBlueAccent], // Same gradient as Detailspage
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20.0), // Adjust padding for consistency
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Credits",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text to contrast with background
              ),
            ),
            SizedBox(height: 25),
            Text(
              "This app was built with the contributions of the following:",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white70, // Softer white for secondary text
              ),
            ),
            SizedBox(height: 20),
            // List of contributors with adjusted spacing and colors
            Text(
              "- Developer: Quazi Zarin Subah\n  Roll : 20220204079",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text for contributors
              ),
            ),
            SizedBox(height: 10),
            Text(
              "- Designer: Arpa Adhikary Tathai\n  Roll : 20220204094",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text for contributors
              ),
            ),
            SizedBox(height: 10),
            Text(
              "- Project Manager: Zarin Tasnim\n  Roll : 20220204096",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text for contributors
              ),
            ),
            SizedBox(height: 10),
            Text(
              "\n\n- Special Thanks: Flutter Community",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70, // Softer white for the special thanks section
              ),
            ),
          ],
        ),
      ),
    );
  }
}
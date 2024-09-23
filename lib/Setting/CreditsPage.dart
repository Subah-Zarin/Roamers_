import 'package:flutter/material.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({super.key});

  @override
  _CreditsPageState createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "This app was built with the contributions of the following:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "- Developer: John Doe",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "- Designer: Jane Smith",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "- Project Manager: Alex Johnson",
              style: TextStyle(fontSize: 16),
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

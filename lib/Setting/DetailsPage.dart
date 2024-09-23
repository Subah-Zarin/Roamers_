import 'package:flutter/material.dart';


class Detailspage extends StatefulWidget {
  const Detailspage({super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<Detailspage> {
  @override
  Widget build(BuildContext context) {
    print("build called: DetailsPage is being built.");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Details Page",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Here are some details about the app:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "- This app helps you manage settings efficiently.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "- It is designed with simplicity and ease of use in mind.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "- More features are coming soon.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

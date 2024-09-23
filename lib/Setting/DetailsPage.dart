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
              "Our Purpose",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Some details about the app:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "  - Trip Planning and Organization.",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "  - Discover Destinations.",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "  - Real-Time Updates.",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "  - Personalized Recommendations.",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "  - Travel Budgeting and Cost Management.",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

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
        backgroundColor: Colors.indigo, // Reverting back to purple AppBar
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.lightBlueAccent], // Revert to purple gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20.0), // Adjust padding for consistency
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Our Purpose",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Ensure the text color contrasts well
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Some details about the app:",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white70, // Softer white text for secondary info
              ),
            ),
            const SizedBox(height: 25),
            // Adding a list of details with icons
            buildDetailItem(Icons.map, "Trip Planning and Organization"),
            buildDetailItem(Icons.explore, "Discover Destinations"),
            buildDetailItem(Icons.update, "Real-Time Updates"),
            buildDetailItem(Icons.recommend, "Personalized Recommendations"),
            buildDetailItem(Icons.money, "Travel Budgeting and Cost Management"),
          ],
        ),
      ),
    );
  }

  // Method to build each detail item with an icon
  Widget buildDetailItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 28), // Softer icon color for better contrast
          const SizedBox(width: 10),
          // Use Expanded to prevent text overflow issues
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white, // White text to match the background
              ),
            ),
          ),
        ],
      ),
    );
  }
}
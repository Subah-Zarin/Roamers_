import 'package:flutter/material.dart';

// The main entry point of the app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(), // Starting page
    );
  }
}


// A simple home page where you can navigate to the DetailsPage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to DetailsPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailsPage(),
              ),
            );
          },
          child: const Text("Go to Details Page"),
        ),
      ),
    );
  }
}

// Your DetailsPage with print statements
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    print("initState called: DetailsPage has been initialized.");
  }

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

  @override
  void dispose() {
    print("dispose called: DetailsPage is being removed.");
    super.dispose();
  }
}

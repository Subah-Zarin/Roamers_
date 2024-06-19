import 'package:flutter/material.dart';

class communitypage extends StatelessWidget {
  const communitypage({super.key});

  final List<Map<String, String>> tours = const [
    {
      "place": "Sajek Valley",
      "image": "assets/images/sajek valley.png",
    },
    {
      "place": "Ratargul Swamp Forest",
      "image": "assets/images/ratargul swamp forest.png",
    },
    {
      "place": "Nuhashpolli",
      "image": "assets/images/nuhaspolli.jpg",
    },
    {
      "place": "Bichanakandi",
      "image": "assets/images/Bichanakandi.jpg",
    },
    {
      "place": "Boga Lake",
      "image": "assets/images/bogalake.jpg",
    },
    {
      "place": "Debotakum",
      "image": "assets/images/debotakhum.jpg",
    },
    {
      "place": "St. Martin Island",
      "image": "assets/images/St.Martin Island.png",
    },
    {
      "place": "Lalakhal",
      "image": "assets/images/lalakhal.jpg",
    },
    {
      "place": "Foyes Lake",
      "image": "assets/images/foyslake.jpg",
    },
    {
      "place": "Golden Temple",
      "image": "assets/images/golden_temple.jpg",
    },
    {
      "place": "Rangamati",
      "image": "assets/images/Hanging Bridge of Rangamati.png",
    },
    {
      "place": "Lalbagh",
      "image": "assets/images/Lalbagh.jpg",
    },
    {
      "place": "Nilgiri",
      "image": "assets/images/Nilgiri.png",
    },
    {
      "place": "Ahsan Manzil",
      "image": "assets/images/ahsan.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community Tours',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          final tour = tours[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  tour["image"]!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                tour["place"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Logic to add user to community tour group
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Join',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class communitypage extends StatelessWidget {
  const communitypage({super.key});

  final List<Map<String, dynamic>> tours = const [
    {
      "place": "Sajek Valley",
      "image": "assets/images/sajek valley.png",
      "date": "2024-07-01",
      "people": 10,
    },
    {
      "place": "Ratargul Swamp Forest",
      "image": "assets/images/ratargul swamp forest.png",
      "date": "2024-07-05",
      "people": 15,
    },
    {
      "place": "Nuhashpolli",
      "image": "assets/images/nuhaspolli.jpg",
      "date": "2024-07-10",
      "people": 20,
    },
    {
      "place": "Bichanakandi",
      "image": "assets/images/Bichanakandi.jpg",
      "date": "2024-07-15",
      "people": 12,
    },
    {
      "place": "Boga Lake",
      "image": "assets/images/bogalake.jpg",
      "date": "2024-07-20",
      "people": 25,
    },
    {
      "place": "Debotakum",
      "image": "assets/images/debotakhum.jpg",
      "date": "2024-07-25",
      "people": 18,
    },
    {
      "place": "St. Martin Island",
      "image": "assets/images/St.Martin Island.png",
      "date": "2024-07-30",
      "people": 30,
    },
    {
      "place": "Lalakhal",
      "image": "assets/images/lalakhal.jpg",
      "date": "2024-08-05",
      "people": 22,
    },
    {
      "place": "Foyes Lake",
      "image": "assets/images/foyslake.jpg",
      "date": "2024-08-10",
      "people": 17,
    },
    {
      "place": "Golden Temple",
      "image": "assets/images/golden_temple.jpg",
      "date": "2024-08-15",
      "people": 14,
    },
    {
      "place": "Rangamati",
      "image": "assets/images/Hanging Bridge of Rangamati.png",
      "date": "2024-08-20",
      "people": 27,
    },
    {
      "place": "Lalbagh",
      "image": "assets/images/Lalbagh.jpg",
      "date": "2024-08-25",
      "people": 19,
    },
    {
      "place": "Nilgiri",
      "image": "assets/images/Nilgiri.png",
      "date": "2024-08-30",
      "people": 16,
    },
    {
      "place": "Ahsan Manzil",
      "image": "assets/images/ahsan.jpg",
      "date": "2024-09-05",
      "people": 21,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community Tours',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.lightBlue[800],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Text(
                'Travel Better with Us',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tours.length,
              itemBuilder: (context, index) {
                final tour = tours[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            tour["image"]!,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tour["place"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.time_outline,
                                    color: Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    ' ${tour["date"]}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.people_outline,
                                    color: Colors.grey[700],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    ' ${tour["people"]} people',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

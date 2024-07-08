import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class hoteldetails extends StatelessWidget {
  const hoteldetails({super.key});

  final List<Map<String, dynamic>> tours = const [
    {
      "name": "Hotel Sajek Paradise",
      "image": "assets/images/ht2.jpeg",
      "price": "5000TK per night",
      "rating": 4.5,
    },
    {
      "name": "Ratargul Swamp Inn",
      "image": "assets/images/ht3.jpeg",
      "price": "3000TK per night",
      "rating": 4.0,
    },
    {
      "name": "Nuhashpolli Resort",
      "image": "assets/images/ht4.jpeg",
      "price": "4500TK per night",
      "rating": 4.2,
    },
    {
      "name": "Bichanakandi Hotel",
      "image": "assets/images/ht5.jpeg",
      "price": "4000TK per night",
      "rating": 4.3,
    },
    {
      "name": "Boga Lake Lodge",
      "image": "assets/images/ht6.jpeg",
      "price": "6000TK per night",
      "rating": 4.7,
    },
    {
      "name": "Debotakum Hotel",
      "image": "assets/images/ht7.jpeg",
      "price": "3500TK per night",
      "rating": 3.9,
    },
    {
      "name": "St. Martin Island Resort",
      "image": "assets/images/ht3.jpeg",
      "price": "7000TK per night",
      "rating": 4.8,
    },
    {
      "name": "Lalakhal Hotel",
      "image": "assets/images/ht1.jpeg",
      "price": "3200TK per night",
      "rating": 4.1,
    },
    {
      "name": "Foyes Lake Resort",
      "image": "assets/images/ht8.jpeg",
      "price": "2800TK per night",
      "rating": 4.0,
    },
    {
      "name": "Golden Temple Hotel",
      "image": "assets/images/ht9.jpg",
      "price": "4000TK per night",
      "rating": 4.4,
    },
    {
      "name": "Rangamati Riverside Hotel",
      "image": "assets/images/ht10.jpeg",
      "price": "3800TK per night",
      "rating": 4.3,
    },
    {
      "name": "Lalbagh Heritage Hotel",
      "image": "assets/images/ht11.jpeg",
      "price": "4200TK per night",
      "rating": 4.2,
    },
    {
      "name": "Nilgiri Hilltop Resort",
      "image": "assets/images/ht12.jpeg",
      "price": "5500TK per night",
      "rating": 4.6,
    },
    {
      "name": "Ahsan Manzil Hotel",
      "image": "assets/images/ht2.jpeg",
      "price": "4600TK per night",
      "rating": 4.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotels',
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
                                tour["name"]!,
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
                                    ' ${tour["price"]}',
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
                                    ' ${tour["rating"]} rating',
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
                                  'Contact',
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

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class hoteldetails extends StatelessWidget {
  const hoteldetails({super.key});

  // This method is defined inside the HotelDetails class
  Future<void> _launchLink(String link) async {
    final Uri url = Uri.parse(link);

    try {
      // Use this to explicitly open the URL in an external browser
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch the link.';
      }
    } catch (e) {
      print(e);
    }
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final hotels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];

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
                        child: Image.network(
                          hotel['image'],
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
                              hotel['name'],
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
                                  ' ${hotel['price']} BDT',
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
                                  Ionicons.star_outline,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  ' ${hotel['rating']} rating',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Pass the hotel's 'link' field to the _launchLink function
                                _launchLink(hotel['link']);
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
          );
        },
      ),
    );
  }
}

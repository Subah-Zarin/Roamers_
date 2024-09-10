import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roamers/models/tourist_places_model.dart';
import '../models/nearby_places_model.dart';
import '../pages/NearbyPlaceDetailsPage.dart';

class DetailScreen extends StatelessWidget {
  final TouristPlacesModel place;

  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('tourist_places')
            .doc(place.name)
            .collection('details')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching details'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No details available'));
          } else {
            final details = snapshot.data!.docs;
            return ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, index) {
                final data = details[index].data() as Map<String, dynamic>;
                final name = data['name'] ?? 'Unknown';
                final imageUrl = data['image'] ?? '';

                // Check if the image is a Base64 string or a URL
                final isBase64 = imageUrl.startsWith('data:image/');

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: InkWell(
                    onTap: () async {
                      // Fetch the name from Firestore
                      String? fetchedName = await fetchNameFromFirestore(place.name);

                      if (fetchedName == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error fetching details')),
                        );
                        return;
                      }

                      // Check if the name matches any in the NearbyPlaceModel list
                      bool isNearbyPlace = nearbyPlaces.any(
                            (place) => place.name == fetchedName,
                      );

                      if (isNearbyPlace) {
                        // Find the matching place from the list
                        final matchingPlace = nearbyPlaces.firstWhere(
                              (place) => place.name == fetchedName,
                        );

                        // Navigate to NearbyPlaceDetailsPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NearbyPlaceDetailsPage(
                              place: matchingPlace,
                            ),
                          ),
                        );
                      } else {
                        // Navigate to RecommendedPlaces
                      }

                      // Show a Snackbar as well
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped on $name')),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    splashColor: Colors.blueAccent.withOpacity(0.3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: isBase64
                                ? Base64ImageWidget(base64String: imageUrl)
                                : Image.network(
                              imageUrl.isNotEmpty
                                  ? imageUrl
                                  : 'assets/images/default.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Function to fetch name from Firestore based on the provided document ID
Future<String?> fetchNameFromFirestore(String documentId) async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('tourist_places')
        .doc(documentId)
        .collection('details')
        .doc('1') // Assuming a single document; adjust as necessary
        .get();

    if (doc.exists) {
      return doc['name'] as String?;
    }
  } catch (e) {
    print('Error fetching name: $e');
  }
  return null;
}

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  Base64ImageWidget({required this.base64String});

  @override
  Widget build(BuildContext context) {
    if (base64String.isNotEmpty) {
      try {
        // Decode Base64 string
        Uint8List bytes = base64Decode(base64String.split(',').last);

        return Image.memory(
          bytes,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return const Text('Error decoding image');
      }
    } else {
      return const Text('No image available');
    }
  }
}

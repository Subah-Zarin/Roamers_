import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../models/models/hotel_details.dart';

class ViewDetailsPage extends StatefulWidget {
  final String placeName;

  const ViewDetailsPage({Key? key, required this.placeName}) : super(key: key);

  @override
  _ViewDetailsPageState createState() => _ViewDetailsPageState();
}

class _ViewDetailsPageState extends State<ViewDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<Map<String, dynamic>> _placeDetails;
  int selectedNumberOfPeople = 1;

  @override
  void initState() {
    super.initState();
    _placeDetails = _fetchPlaceDetails();
  }

  Future<Map<String, dynamic>> _fetchPlaceDetails() async {
    try {
      final snapshot = await _firestore
          .collection('tours')
          .where('place', isEqualTo: widget.placeName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return {
          'description': data['description'] ?? 'No description available',
          'price': data['per_person_price'] ?? 'No price available', // Updated field name
          'imageUrl': data['image'] ?? '', // Fetch the image URL if available
        };
      } else {
        return {
          'description': 'No description available',
          'price': 'No price available',
          'imageUrl': '', // Default value if no image URL is available
        };
      }
    } catch (e) {
      print("Error fetching place details: $e");
      return {
        'description': 'Error fetching description',
        'price': 'Error fetching price',
        'imageUrl': '',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("View Details"),
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _placeDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading details'));
            } else {
              final details = snapshot.data!;
              return ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      image: details['imageUrl'].isNotEmpty
                          ? DecorationImage(
                        image: NetworkImage(details['imageUrl']),
                        fit: BoxFit.cover,
                      )
                          : null,
                      color: Colors.grey[300], // Default color if no image
                    ),
                    child: details['imageUrl'].isEmpty
                        ? Center(child: Text('No Image Available'))
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.placeName,
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Per person: ${details['price']} BDT",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.orange),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      details['description'],
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _buildNumberOfPeopleSelector(),
                  ),
                  const SizedBox(height: 20),
                  _buildActionButtons(context),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildNumberOfPeopleSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Number of people: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                setState(() {
                  if (selectedNumberOfPeople > 1) {
                    selectedNumberOfPeople--;
                  }
                });
              },
            ),
            Text(
              selectedNumberOfPeople.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                setState(() {
                  if (selectedNumberOfPeople < 5) { // Limit the max number of people
                    selectedNumberOfPeople++;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const hoteldetails(), // Replace with actual hotel details page
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange, // Background color of the button
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
          ),
          child: Text(
            'Hotels',
            style: TextStyle(
              color: Colors.white, // Text color of the button
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

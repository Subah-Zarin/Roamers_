import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roamers/models/nearby_places_model.dart';

import '../pages/NearbyPlaceDetailsPage.dart'; // Update with the correct import path

class ViewAllPage extends StatefulWidget {
  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _tours = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTours();
  }

  void _fetchTours() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('tours').get();
      setState(() {
        _tours = snapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToDetails(String placeName) {
    // Attempt to find a matching place
    NearbyPlaceModel? place = nearbyPlaces.firstWhere(
          (p) => p.name == placeName,
    );

    if (place != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NearbyPlaceDetailsPage(place: place),
        ),
      );
    } else {
      // Show an error message if the place is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No details available for: $placeName'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View All Tours'),
        backgroundColor: Colors.cyan[800],
        elevation: 4,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _tours.length,
          itemBuilder: (context, index) {
            var tourData = _tours[index].data() as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                _navigateToDetails(tourData['place'] ?? 'No Name');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      tourData['image'] != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        child: Image.network(
                          tourData['image'],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 50, color: Colors.white),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tourData['place'] ?? 'No Name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan[800],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

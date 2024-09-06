import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roamers/models/nearby_places_model.dart';
import '../pages/NearbyPlaceDetailsPage.dart';

class SearchAndDetailsPage extends StatefulWidget {
  @override
  _SearchAndDetailsPageState createState() => _SearchAndDetailsPageState();
}

class _SearchAndDetailsPageState extends State<SearchAndDetailsPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _allPlaces = [];
  List<DocumentSnapshot> _searchResults = [];
  bool _isSearching = false;
  DocumentSnapshot? _selectedPlace;

  @override
  void initState() {
    super.initState();
    _fetchAllPlaces();
  }

  void _fetchAllPlaces() async {
    setState(() {
      _isSearching = true;
    });

    try {
      QuerySnapshot snapshot = await _firestore.collection('tours').get();
      setState(() {
        _allPlaces = snapshot.docs;
        _searchResults = _allPlaces;
        _isSearching = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _searchPlaces(String query) {
    setState(() {
      _isSearching = true;
    });

    if (query.isEmpty) {
      setState(() {
        _searchResults = _allPlaces;
        _isSearching = false;
      });
      return;
    }

    final lowerCaseQuery = query.toLowerCase();
    final filteredResults = _allPlaces.where((doc) {
      final placeName = (doc.data() as Map<String, dynamic>)['place'] ?? '';
      return placeName.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      _searchResults = filteredResults;
      _isSearching = false;
    });
  }

  void _onPlaceTap(DocumentSnapshot placeDoc) {
    final placeData = placeDoc.data() as Map<String, dynamic>;
    final placeName = placeData['place'] ?? '';

    // Find matching place
    final matchingPlace = nearbyPlaces.firstWhere(
          (place) => place.name.toLowerCase() == placeName.toLowerCase(),
      orElse: () => NearbyPlaceModel(
        name: 'Not Found',
        duration: 'Unknown',
        rating: 0.0,
        distance: 0.0,
        images: [],
      ),
    );


    if (matchingPlace.name != 'Not Found') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NearbyPlaceDetailsPage(place: matchingPlace),
        ),
      );
    } else {
      print('No matching place found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSearchQuery = _searchController.text.isNotEmpty;
    final showSuggestions = !hasSearchQuery && _searchResults.isEmpty && _selectedPlace == null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.cyan[800],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: _searchPlaces,
              decoration: InputDecoration(
                labelText: 'Search for a place',
                prefixIcon: Icon(Icons.search, color: Colors.cyan[800]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.cyan[800]!, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.cyan[800]!, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.cyan[800]!, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 16),
            if (showSuggestions)
              _buildSuggestions(),
            _isSearching
                ? Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  var placeData = _searchResults[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        _onPlaceTap(_searchResults[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            placeData['image'] != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              child: Image.network(
                                placeData['image'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Icon(Icons.image, size: 40),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                placeData['place'] ?? 'No Name',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
            if (_selectedPlace != null) _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.cyan[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        'Start typing to search for places. You can find various tourist attractions here.',
        style: TextStyle(fontSize: 16, color: Colors.cyan[800]),
      ),
    );
  }

  Widget _buildDetails() {
    var placeData = _selectedPlace!.data() as Map<String, dynamic>;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.cyan[50],
        borderRadius: BorderRadius.circular(12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          placeData['image'] != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              placeData['image'],
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          )
              : Container(
            width: 160,
            height: 160,
            color: Colors.grey[300],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeData['place'] ?? 'No Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[800],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Click to know more information about this place.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

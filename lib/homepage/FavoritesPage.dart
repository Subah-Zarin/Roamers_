import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Fetch stored favorites from Firebase
  Future<List<Map<String, dynamic>>> _fetchFavoritesFromFirebase() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];

    final userFavoritesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    List<Map<String, dynamic>> fetchedFavorites = [];
    for (var doc in userFavoritesSnapshot.docs) {
      final data = doc.data();
      fetchedFavorites.add({
        'name': data['name'], // Only the name is fetched
        'docId': doc.id, // Include the document ID for deletion
      });
    }
    return fetchedFavorites;
  }

  // Delete a favorite from Firebase
  Future<void> _removeFavoriteFromFirebase(String docId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(docId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple[200],
        centerTitle: true,
        elevation: 5,
        leading: Icon(Icons.favorite, color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchFavoritesFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching favorites"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No favorites yet.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final favorites = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              final docId = favorite['docId'];

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  title: Text(
                    favorite['name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () {
                      _removeFavoriteFromFirebase(docId);
                      setState(() {}); // Refresh the UI after deleting
                    },
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

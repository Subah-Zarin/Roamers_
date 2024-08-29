import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';

import 'JoinedToursPage.dart';

class communitypage extends StatefulWidget {
  const communitypage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<communitypage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
  }

  Stream<QuerySnapshot> fetchTours() {
    return FirebaseFirestore.instance.collection('tours').snapshots();
  }

  void showCustomSnackBar(String message, {bool isSuccess = true}) {
    final backgroundColor = isSuccess ? Colors.white : Colors.red[700];
    final textColor = Colors.white;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Increment the 'people' count and add to the user's joined tours collection
  Future<void> joinTour(DocumentSnapshot tour) async {
    final String userId = currentUser!.uid;
    final String tourPlace = tour['place'];

    try {
      final joinedToursCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('joined_tours');


      final query = await joinedToursCollection.where('place', isEqualTo: tourPlace).get();

      if (query.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('tours').doc(tour.id).update({
          'people': FieldValue.increment(1),
        });

        await joinedToursCollection.add({
          'place': tourPlace,
          'image': tour['image'],
          'date': tour['date'],
        });

        showCustomSnackBar('You have joined the $tourPlace tour!');
      } else {
        showCustomSnackBar('You have already joined the $tourPlace tour.', isSuccess: false);
      }
    } catch (e) {
      showCustomSnackBar('Error: Could not join tour.', isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community Tours',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Ionicons.cart_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JoinedToursPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Center(
              child: Text(
                'Travel Better with Us',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fetchTours(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No tours available.'));
                }

                final tours = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: tours.length,
                  itemBuilder: (context, index) {
                    final tour = tours[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                tour['image'],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tour['place'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
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
                                        tour['date'],
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
                                        '${tour['people']} people',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () => joinTour(tour),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      'Join',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
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
          ),
        ],
      ),
    );
  }
}

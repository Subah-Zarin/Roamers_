import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:roamers/widget/custom_icon_button.dart';
import 'package:roamers/widget/location_card.dart';
import 'package:roamers/widget/nearby_places.dart';
import 'package:roamers/widget/recommended_places.dart';
import 'package:roamers/widget/tourist_places.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Unforgettable Experience"),
            Text(
              "Drive into your dream tour",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        actions: const [
          CustomIconButton(
            icon: Icon(Ionicons.search_outline),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: Icon(Ionicons.notifications_outline),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          // LOCATION CARD
          const LocationCard(),
          const SizedBox(
            height: 15,
          ),
          const TouristPlaces(),
          // CATEGORIES
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommendation",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(onPressed: () {}, child: const Text("View All"))
            ],
          ),
          const SizedBox(height: 10),
          const RecommendedPlaces(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Most Visited Places",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(onPressed: () {}, child: const Text("View All"))
            ],
          ),
          const SizedBox(height: 10),
          const NearbyPlaces(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Ionicons.home_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'homepage');
              },
            ),
            label: "Homepage",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Ionicons.heart_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'Favourite');
              },
            ),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Ionicons.people_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'Community');
              },
            ),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Ionicons.person_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'Profile');
              },
            ),
            label: "Profile",
          ),
        ],
      ),


    );
  }
}

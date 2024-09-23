import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:roamers/homepage/viewall.dart';
import 'package:roamers/search/search.dart';
import 'package:roamers/widget/custom_icon_button.dart';
import 'package:roamers/widget/location_card.dart';
import 'package:roamers/widget/nearby_places.dart';
import 'package:roamers/widget/recommended_places.dart';
import 'package:roamers/widget/tourist_places.dart';

import '../Setting/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ThemeMode _themeMode = ThemeMode.system;

  /*void _handleThemeChanged(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }*/

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
        actions: [
          CustomIconButton(
            icon: const Icon(Ionicons.search_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchAndDetailsPage(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: const Icon(Ionicons.settings_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Setting(),
                    //builder: (context) => Setting(
                      //onThemeChanged: _handleThemeChanged,
                    ),
                );
              },
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
          const SizedBox(height: 15),
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAllPage()),
                  );
                },
                child: const Text("View All"),
              ),
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAllPage()),
                  );
                },
                child: const Text("View All"),
              ),
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
              icon: const Icon(Ionicons.home_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'homepage');
              },
            ),
            label: "Homepage",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Ionicons.heart_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'FavoritesPage');
              },
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Ionicons.people_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'communitypage');
              },
            ),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Ionicons.person_outline),
              onPressed: () {
                Navigator.pushNamed(context, 'profile');
              },
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

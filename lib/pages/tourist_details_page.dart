import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:roamers/pages/view_details.dart';
import 'package:roamers/widget/distance.dart';

import '../homepage/favorites_provider.dart';
import '../models/tourist_attraction_model.dart';


class TouristDetailsPage extends StatelessWidget {
  final TouristAttraction attraction;

  const TouristDetailsPage({Key? key, required this.attraction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = FavoritesProvider.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: size.height * 0.38,
              width: double.infinity,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: attraction.images.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: AssetImage(attraction.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: size.height * 0.38,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1.0,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () {
                              provider.toggleFavorite(attraction);       // Changed here
                            },
                            icon: Icon(
                              provider.isExist(attraction)                 // Changed here
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attraction.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${attraction.distance.toStringAsFixed(1)} km",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 20,
                    icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      attraction.rating.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      attraction.duration,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Started in",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 180,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                image: const DecorationImage(
                  image: AssetImage('assets/images/map2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Distance(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewDetailsPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 8.0,
                ),
              ),
              child: const Text("View details"),
            ),
          ],
        ),
      ),
    );
  }
}
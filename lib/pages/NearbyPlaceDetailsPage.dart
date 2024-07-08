import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:roamers/widget/distance.dart';
import '../homepage/favorites_provider.dart';
import '../models/nearby_places_model.dart';

class NearbyPlaceDetailsPage extends StatefulWidget {
  final NearbyPlaceModel place;

  const NearbyPlaceDetailsPage({Key? key, required this.place}) : super(key: key);

  @override
  _NearbyPlaceDetailsPageState createState() => _NearbyPlaceDetailsPageState();
}

class _NearbyPlaceDetailsPageState extends State<NearbyPlaceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);
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
                  Image.asset(
                    widget.place.images.first,
                    width: double.infinity,
                    height: size.height * 0.38,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 20,
                        icon: const Icon(Ionicons.chevron_back),
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
                      widget.place.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${widget.place.distance.toStringAsFixed(1)} km",
                      style: Theme.of(context).textTheme.bodySmall,
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
                      widget.place.rating.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(
                      Icons.star,
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
                      widget.place.duration,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Started in",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Distance(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add navigation or functionality as needed
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
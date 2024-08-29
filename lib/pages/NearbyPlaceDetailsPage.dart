import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:roamers/pages/view_details.dart';
import 'package:roamers/widget/distance.dart';
import '../homepage/favorites_provider.dart';
import '../models/nearby_places_model.dart';
import 'direction_model.dart';

class NearbyPlaceDetailsPage extends StatefulWidget {
  final NearbyPlaceModel place;

  const NearbyPlaceDetailsPage({Key? key, required this.place}) : super(key: key);

  @override
  _NearbyPlaceDetailsPageState createState() => _NearbyPlaceDetailsPageState();
}

class _NearbyPlaceDetailsPageState extends State<NearbyPlaceDetailsPage> {
  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(23.8103, 90.4125), // Coordinates for Dhaka, Bangladesh
    zoom: 11.5,
  );

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<FavoritesProvider<NearbyPlaceModel>>(context);
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
                    itemCount: widget.place.images.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: AssetImage(widget.place.images[index]),
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
                              //Navigator.pushNamed(context, 'FavoritesPageNearby');;
                            },
                            icon: Icon(
                              //provider.isExist(widget.place)
                                  //? Icons.favorite
                                  //: Icons.favorite_border,
                              Icons.favorite_border,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 5),
                Text(
                  "${widget.place.distance.toStringAsFixed(1)} km",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Started in", // Replace with relevant detail if needed
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {
                      // Handle chat or communication action if needed
                    },
                    iconSize: 20,
                    icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.place.rating.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
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
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                image: const DecorationImage(
                  image: AssetImage('assets/images/map2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
                markers: {
                  if (_origin != null) _origin!,
                  if (_destination != null) _destination!,
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.blue,
                      width: 5,
                      points: _info!.polylinePoints
                          .map((point) => LatLng(point.latitude, point.longitude))
                          .toList(),
                    ),
                },
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

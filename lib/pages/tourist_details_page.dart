import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:roamers/pages/view_details.dart';
import 'package:roamers/widget/distance.dart';
import 'package:roamers/models/tourist_attraction_model.dart';
import 'package:roamers/pages/direction_model.dart';
import 'package:roamers/pages/direction_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TouristDetailsPage extends StatefulWidget {
  final TouristAttraction attraction;

  const TouristDetailsPage({Key? key, required this.attraction}) : super(key: key);

  @override
  _TouristDetailsPageState createState() => _TouristDetailsPageState();
}

class _TouristDetailsPageState extends State<TouristDetailsPage> {
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
                    itemCount: widget.attraction.images.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: AssetImage(widget.attraction.images[index]),
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
                            onPressed: () {},
                            icon: const Icon(Ionicons.heart_outline),
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
                      widget.attraction.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${widget.attraction.distance.toStringAsFixed(1)} km",
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
                      widget.attraction.rating.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
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
                      widget.attraction.duration,
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
            Container(
              height: 180,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                image: const DecorationImage(
                  image: AssetImage('assets/images/map.png'),
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
                      color: Colors.red,
                      width: 5,
                      points: _info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
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


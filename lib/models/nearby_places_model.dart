class NearbyPlaceModel {
  final String name;
  final String duration;
  final double rating;
  final double distance;
  final List<String> images;

  NearbyPlaceModel({
    required this.name,
    required this.duration, // Added
    required this.rating, // Added
    required this.distance, // Added
    required this.images, // Added
  });
}

List<NearbyPlaceModel> nearbyPlaces = [
  NearbyPlaceModel(
    name: "Ahsan Manzil", // Added
    duration: "1 hour", // Added
    rating: 4.5, // Added
    distance: 2.5, // Added
    images: ["assets/images/ahsan.jpg"], // Modified
  ),
  NearbyPlaceModel(
    name: "Bichanakandi", // Added
    duration: "2 hours", // Added
    rating: 4.7, // Added
    distance: 5.0, // Added
    images: ["assets/images/Bichanakandi.jpg"], // Modified
  ),
  NearbyPlaceModel(
    name: "Foy's Lake", // Added
    duration: "1.5 hours", // Added
    rating: 4.4, // Added
    distance: 3.0, // Added
    images: ["assets/images/foyslake.jpg"], // Modified
  ),
  NearbyPlaceModel(
    name: "Nuhas Polli", // Added
    duration: "2.5 hours", // Added
    rating: 4.6, // Added
    distance: 6.0, // Added
    images: ["assets/images/nuhaspolli.jpg"], // Modified
  ),
  NearbyPlaceModel(
    name: "Boga Lake", // Added
    duration: "3 hours", // Added
    rating: 4.8, // Added
    distance: 7.5, // Added
    images: ["assets/images/bogalake.jpg"], // Modified
  ),
  NearbyPlaceModel(
    name: "Lalakhal", // Added
    duration: "2 hours", // Added
    rating: 4.7, // Added
    distance: 5.5, // Added
    images: ["assets/images/lalakhal.jpg"], // Modified
  ),
  NearbyPlaceModel(
    name: "Golden Temple", // Added
    duration: "1 hour", // Added
    rating: 4.5, // Added
    distance: 2.0, // Added
    images: ["assets/images/golden_temple.jpg"], // Modified
  ),
  NearbyPlaceModel(
    name: "Lalbagh Fort", // Added
    duration: "1.5 hours", // Added
    rating: 4.6, // Added
    distance: 3.5, // Added
    images: ["assets/images/Lalbagh.jpg"],
  ),
];

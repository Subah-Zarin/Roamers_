
class RecommendedPlaceModel {
  final String image;
  final double rating;
  final String name;
  final String location;
  RecommendedPlaceModel({
    required this.image,
    required this.rating,
    required this.name,
    required this.location,
  });
}

List<RecommendedPlaceModel> recommendedPlaces = [
  RecommendedPlaceModel(
    image: "assets/images/Hanging Bridge of Rangamati.png",
    rating: 4.4,
    name: "Hanging Bridge of Rangamati",
    location: "Rangamati",
  ),
  RecommendedPlaceModel(
    image: "assets/images/Nilgiri.png",
    rating: 4.2,
    name: "Nilgiri Bandarban",
    location: "Bandarban",
  ),
  RecommendedPlaceModel(
    image: "assets/images/ratargul swamp forest.png",
    rating: 4.0,
    name: "Ratargul Swamp Forest Sylhet",
    location : "Sylhet",
  ),
  RecommendedPlaceModel(
    image: "assets/images/sajek valley.png",
    rating: 4.4,
    name: "Sajek Valley",
    location: "Rangamati"
  ),
  RecommendedPlaceModel(
    image: "assets/images/St.Martin Island.png",
    rating: 4.3,
    name: "St.Martin Island",
    location: "Taknaf"
  ),
];

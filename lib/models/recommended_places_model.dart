
class RecommendedPlaceModel {
  final String image;
  final double rating;
  final String location;
  RecommendedPlaceModel({
    required this.image,
    required this.rating,
    required this.location,
  });
}

List<RecommendedPlaceModel> recommendedPlaces = [
  RecommendedPlaceModel(
    image: "assets/images/Hanging Bridge of Rangamati.png",
    rating: 4.4,
    location: "Hanging Bridge of Rangamati",
  ),
  RecommendedPlaceModel(
    image: "assets/images/Nilgiri.png",
    rating: 4.4,
    location: "Nilgiri Bandarban",
  ),
  RecommendedPlaceModel(
    image: "assets/images/ratargul swamp forest.png",
    rating: 4.4,
    location: "Ratargul Swamp Forest Sylhet",
  ),
  RecommendedPlaceModel(
    image: "assets/images/sajek valley.png",
    rating: 4.4,
    location: "Sajek Valley",
  ),
  RecommendedPlaceModel(
    image: "assets/images/St.Martin Island.png",
    rating: 4.4,
    location: "St.Martin Island",
  ),
];

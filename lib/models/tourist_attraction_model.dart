class TouristAttraction {
  final String name;
  final List<String> images;
  final double distance;
  final double rating;
  final String duration;


  TouristAttraction({
    required this.name,
    required this.images,
    required this.distance,
    required this.rating,
    required this.duration,

  });
}
List<TouristAttraction> touristAttractions = [
  TouristAttraction(
    name: "Hanging Bridge of Rangamati",
    images: ["assets/images/Hanging Bridge of Rangamati.png", "assets/images/Hanging bridge of Rangamati2.jpg", "assets/images/hanging bridge of Rangamati3.jpg"],
    distance: 311.2,
    rating: 4.6,
    duration: "8hr:24min",

  ),
  TouristAttraction(
    name: "Nilgiri",
    images: ["assets/images/Nilgiri.png", "assets/images/nilgiri2.jpg", "assets/images/nilgiri3.jpg"],
    distance: 10.5,
    rating: 4.8,
    duration: "02d:15h:20m",
  ),
  TouristAttraction(
    name: "Ratargul Swamp Forest",
    images: ["assets/images/ratargul swamp forest.png", "assets/images/ratargul2.jpeg", "assets/images/ratargul3.jpeg"],
    distance: 10.5,
    rating: 4.8,
    duration: "02d:15h:20m",
  ),
  TouristAttraction(
    name: "Sajek Valley",
    images: ["assets/images/sajek valley.png", "assets/images/sajek2.jpeg", "assets/images/sajek3.jpeg"],
    distance: 10.5,
    rating: 4.8,
    duration: "02d:15h:20m",
  ),
  TouristAttraction(
    name: "St.Martin Island",
    images: ["assets/images/St.Martin Island.png", "assets/images/st.martin2.jpeg", "assets/images/st.martin3.jpeg"],
    distance: 10.5,
    rating: 4.8,
    duration: "02d:15h:20m",
  ),
];

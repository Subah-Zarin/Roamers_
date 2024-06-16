// ignore_for_file: public_member_api_docs, sort_constructors_first
class TouristPlacesModel {
  final String name;
  final String image;
  TouristPlacesModel({
    required this.name,
    required this.image,
  });
}

List<TouristPlacesModel> touristPlaces = [
  TouristPlacesModel(name: "Mountain", image: "assets/images/mountain.png"),
  TouristPlacesModel(name: "Beach", image: "assets/images/beach.png"),
  TouristPlacesModel(name: "Forest", image: "assets/images/forest.png"),
  TouristPlacesModel(name: "City", image: "assets/images/city.png"),
  TouristPlacesModel(name: "Desert", image: "assets/images/desert.png"),
];

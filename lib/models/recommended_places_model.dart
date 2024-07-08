// recommended_places_model.dart

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

  factory RecommendedPlaceModel.fromFirestore(Map<String, dynamic> json) {
    return RecommendedPlaceModel(
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      name: json['name'] ?? 'Unknown Place',
      location: json['location'] ?? 'Unknown Location',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/nearby_places_model.dart';
import '../models/tourist_attraction_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<TouristAttraction> _favoriteTouristAttractions = [];
  final List<NearbyPlaceModel> _favoriteNearbyPlaces = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TouristAttraction> get favoriteTouristAttractions => _favoriteTouristAttractions;
  List<NearbyPlaceModel> get favoriteNearbyPlaces => _favoriteNearbyPlaces;

  Future<void> toggleFavorite(dynamic place, String userId) async {
    final favoriteRef = _firestore.collection('users').doc(userId).collection('favorites');

    if (place is TouristAttraction) {
      _toggleTouristAttractionFavorite(place, favoriteRef);
    } else if (place is NearbyPlaceModel) {
      _toggleNearbyPlaceFavorite(place, favoriteRef);
    }

    notifyListeners();
  }

  void _toggleTouristAttractionFavorite(TouristAttraction attraction, CollectionReference favoriteRef) async {
    if (_favoriteTouristAttractions.contains(attraction)) {
      _favoriteTouristAttractions.remove(attraction);

      // Remove from Firestore
      final querySnapshot = await favoriteRef.where('name', isEqualTo: attraction.name).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      _favoriteTouristAttractions.add(attraction);

      // Add to Firestore
      await favoriteRef.add({
        'name': attraction.name,
        // Add any other fields if necessary
      });
    }
  }

  void _toggleNearbyPlaceFavorite(NearbyPlaceModel place, CollectionReference favoriteRef) async {
    if (_favoriteNearbyPlaces.contains(place)) {
      _favoriteNearbyPlaces.remove(place);

      // Remove from Firestore
      final querySnapshot = await favoriteRef.where('name', isEqualTo: place.name).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      _favoriteNearbyPlaces.add(place);

      // Add to Firestore
      await favoriteRef.add({
        'name': place.name,
        // Add any other fields if necessary
      });
    }
  }

  bool isExist(dynamic place) {
    if (place is TouristAttraction) {
      return _favoriteTouristAttractions.contains(place);
    } else if (place is NearbyPlaceModel) {
      return _favoriteNearbyPlaces.contains(place);
    }
    return false;
  }

  static FavoritesProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoritesProvider>(context, listen: listen);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tourist_attraction_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<TouristAttraction> _favorites = [];

  List<TouristAttraction> get favorites => _favorites;

  void toggleFavorite(TouristAttraction attraction) {
    if (_favorites.contains(attraction)) {
      _favorites.remove(attraction);
    } else {
      _favorites.add(attraction);
    }
    notifyListeners();
  }

  bool isExist(TouristAttraction attraction) {
    final isExist = _favorites.contains(attraction);
    return isExist;
  }

  static FavoritesProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoritesProvider>(
      context,
      listen: listen,
    );
  }
}

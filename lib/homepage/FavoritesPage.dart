import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorites_provider.dart';




class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = FavoritesProvider.of(context);
    final favorites = provider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: favorites.isEmpty
          ? Center(
        child: Text("No favorites yet."),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final attraction = favorites[index];
          return ListTile(
            title: Text(attraction.name),
            subtitle: Text("${attraction.distance.toStringAsFixed(1)} km"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                provider.toggleFavorite(attraction);
              },
            ),
          );
        },
      ),
    );
  }
}

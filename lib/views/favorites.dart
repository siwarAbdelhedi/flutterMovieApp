import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_grid.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return movieProvider.favoriteMovies.isEmpty
              ? Center(child: Text('No favorite movies yet.'))
              : MovieGrid(
            movies: movieProvider.favoriteMovies,
            onLoadMore: () {}, // No need to load more on favorites page
            onToggleFavorite: movieProvider.toggleFavorite,
            isFavorite: movieProvider.isFavorite,
          );
        },
      ),
    );
  }
}
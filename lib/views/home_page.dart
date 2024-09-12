import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_grid.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      drawer: AppDrawer(),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return MovieGrid(
            movies: movieProvider.movies,
            onLoadMore: movieProvider.loadMovies,
            onToggleFavorite: movieProvider.toggleFavorite,
            isFavorite: movieProvider.isFavorite,
          );
        },
      ),
    );
  }
}
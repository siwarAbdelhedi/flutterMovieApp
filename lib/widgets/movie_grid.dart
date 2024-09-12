import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieGrid extends StatelessWidget {
  final List<CinemaItem> movies;
  final VoidCallback onLoadMore;
  final Function(CinemaItem) onToggleFavorite;
  final Function(CinemaItem) isFavorite;

  const MovieGrid({
    Key? key,
    required this.movies,
    required this.onLoadMore,
    required this.onToggleFavorite,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemCount: movies.length + 1,
      itemBuilder: (context, index) {
        if (index == movies.length) {
          onLoadMore();
          return Center(child: CircularProgressIndicator());
        }
        return _buildMovieItem(context, movies[index]);
      },
    );
  }

  Widget _buildMovieItem(BuildContext context, CinemaItem movie) {
    return GestureDetector(
      onTap: () => _showMovieDetails(context, movie),
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite(movie) ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () => onToggleFavorite(movie),
            ),
          ],
        ),
      ),
    );
  }

  void _showMovieDetails(BuildContext context, CinemaItem movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(movie.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Year: ${movie.year}'),
            Text('Runtime: ${movie.runtime}'),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../services/movies_api_services.dart';

class MovieProvider with ChangeNotifier {
  final CinemaApiClient _apiClient = CinemaApiClient();
  List<CinemaItem> _movies = [];
  List<CinemaItem> _favoriteMovies = [];
  bool _isLoading = false;
  int _currentPage = 1;

  List<CinemaItem> get movies => _movies;
  List<CinemaItem> get favoriteMovies => _favoriteMovies;
  bool get isLoading => _isLoading;

  Future<void> loadMovies() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final newMovies = await _apiClient.retrieveCinemaItems(_currentPage);
      _movies.addAll(newMovies);
      _currentPage++;
    } catch (e) {
      print('Error loading movies: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(CinemaItem movie) {
    final isAlreadyFavorite = _favoriteMovies.contains(movie);
    if (isAlreadyFavorite) {
      _favoriteMovies.remove(movie);
    } else {
      _favoriteMovies.add(movie);
    }
    notifyListeners();
  }

  bool isFavorite(CinemaItem movie) {
    return _favoriteMovies.contains(movie);
  }

  void dispose() {
    _apiClient.dispose();
  }
}
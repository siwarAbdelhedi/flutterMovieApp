class CinemaItem {
  final String imdbID;
  final String title;
  final String year;
  final String poster;
  final String runtime;
  bool isFavorite;

  CinemaItem({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
    required this.runtime,
    this.isFavorite = false,
  });

  factory CinemaItem.fromMap(Map<String, dynamic> map) {
    return CinemaItem(
      imdbID: map['imdbID'] ?? '',
      title: map['Title'] ?? '',
      year: map['Year'] ?? '',
      poster: map['Poster'] ?? '',
      runtime: map['Runtime'] ?? '',
    );
  }
}
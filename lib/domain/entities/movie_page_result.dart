import 'movie.dart';

class MoviePageResult {
  final List<Movie> movies;
  final int currentPage;
  final int totalPages;

  MoviePageResult({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });
}


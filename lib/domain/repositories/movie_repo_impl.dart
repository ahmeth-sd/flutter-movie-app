import '../entities/movie.dart';

abstract class IMovieRepository {
  Future<List<Movie>> getMovies(int page);
}
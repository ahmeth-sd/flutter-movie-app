import '../entities/movie.dart';
import '../repositories/movie_repo_impl.dart';

class GetMoviesUseCase {
  final IMovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<Movie>> call(int page) async {
    return await repository.getMovies(page);
  }
}
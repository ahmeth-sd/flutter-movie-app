import 'package:dio/dio.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repo_impl.dart';
import '../models/movie_model.dart';

class MovieRepository implements IMovieRepository {
  final Dio dio;

  MovieRepository(this.dio);

  @override
  Future<List<Movie>> getMovies(int page) async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular',
        queryParameters: {
          'api_key': 'eea62e401d7586996e90c9846813d444',
          'language': 'en-US',
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['results'];
        return data.map<Movie>((json) {
          final model = MovieModel.fromJson(json);
          return Movie(
            id: model.id,
            title: model.title,
            description: model.overview,
            imageUrl: model.posterPath != null
                ? 'https://image.tmdb.org/t/p/w500${model.posterPath}'
                : null,
          );
        }).toList();
      } else {
        throw Exception('Film listesi alınamadı. Kod: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Film verisi alınırken hata oluştu: $e');
    }
  }
}
import 'package:dio/dio.dart';

class Movie {
  final int id;
  final String title;
  final String? description;
  final String? imageUrl;

  Movie({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });
}

abstract class IMovieRepository {
  Future<List<Movie>> getMovies(int page);
}

class MovieRepository implements IMovieRepository {
  final Dio dio;

  // API anahtarını constructor’dan alabilirsin
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
        final List<dynamic> data = response.data['results'];
        return data.map((json) {
          return Movie(
            id: json['id'],
            title: json['title'] ?? '',
            description: json['overview'] ?? '',
            imageUrl: json['poster_path'] != null
                ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
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

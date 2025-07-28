import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/favorite_movie_model.dart';

abstract class FavoriteMovieRemoteDataSource {
  Future<void> toggleFavorite(String token, String movieId);
  Future<List<FavoriteMovieModel>> getFavoriteMovies(String token, {int page = 1, int pageSize = 20});
}

class FavoriteMovieRemoteDataSourceImpl implements FavoriteMovieRemoteDataSource {
  final http.Client client;

  FavoriteMovieRemoteDataSourceImpl({required this.client});

  @override
  Future<void> toggleFavorite(String token, String movieId) async {
    final url = Uri.parse('https://caseapi.servicelabs.tech/movie/favorite/$movieId');

    final response = await client.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('error.toggleFavoriteFailed');
    }
  }

  @override
  Future<List<FavoriteMovieModel>> getFavoriteMovies(String token, {int page = 1, int pageSize = 20}) async {
    final url = Uri.parse('https://caseapi.servicelabs.tech/movie/favorites?page=$page&pageSize=$pageSize');

    final response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final moviesJson = decoded['data'];

      if (moviesJson == null || moviesJson is! List) {
        print("️ getFavoriteMovies: 'data' alanı boş ya da liste değil");
        return [];
      }

      print(" getFavoriteMovies: "+moviesJson.length.toString()+" favori film alındı");
      return moviesJson.map((json) => FavoriteMovieModel.fromJson(json)).toList();
    } else {
      throw Exception('error.getFavoritesFailed');
    }
  }
}

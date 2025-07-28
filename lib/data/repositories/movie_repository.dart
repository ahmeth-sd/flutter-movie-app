import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repo_impl.dart';
import '../services/auth_service.dart';
import '../datasources/movie_remote_datasource.dart';
import '../../domain/entities/movie_page_result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MovieRepository implements IMovieRepository {
  final AuthService authService;
  final http.Client client;
  final MovieRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  MovieRepository({
    required this.authService,
    required this.client,
    required this.remoteDataSource,
    required this.secureStorage,
  });

  // MoviePageResult döndüren yeni fonksiyon
  Future<MoviePageResult> getMoviesPageResult(int page) async {
    final token = await secureStorage.read(key: 'token');
    if (token == null) throw Exception('Kullanıcı tokenı bulunamadı!');
    return await remoteDataSource.getMovies(page: page, token: token);
  }

  // Eski interface ile uyumlu, sadece film listesi döndüren fonksiyon
  @override
  Future<List<Movie>> getMovies(int page) async {
    final result = await getMoviesPageResult(page);
    return result.movies;
  }
}
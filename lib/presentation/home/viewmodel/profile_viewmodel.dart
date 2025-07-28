import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../data/datasources/favorite_movie_remote_datasource.dart';
import '../../../data/models/favorite_movie_model.dart';
import '../../../domain/entities/favorite_movie_entity.dart';

class ProfileViewModel extends ChangeNotifier {
  final FavoriteMovieRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  ProfileViewModel({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  List<FavoriteMovieEntity> _favoriteMovies = [];
  List<FavoriteMovieEntity> get favoriteMovies => _favoriteMovies;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _error;
  String? get error => _error;
  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;
  static const int _pageSize = 5;

  Future<void> loadFavorites({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _favoriteMovies = [];
    }
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final token = await secureStorage.read(key: 'token');
      if (token == null) throw Exception('Kullanıcı tokenı bulunamadı!');
      final models = await remoteDataSource.getFavoriteMovies(token, page: _currentPage, pageSize: _pageSize);
      final movies = models.map((e) => e.toEntity()).toList();
      if (_currentPage == 1) {
        _favoriteMovies = movies;
      } else {
        _favoriteMovies.addAll(movies);
      }
      _hasMore = movies.length == _pageSize;
    } catch (e) {
      _error = e.toString();
      if (_currentPage == 1) _favoriteMovies = [];
      _hasMore = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreFavorites() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    notifyListeners();
    try {
      _currentPage++;
      final token = await secureStorage.read(key: 'token');
      if (token == null) throw Exception('Kullanıcı tokenı bulunamadı!');
      final models = await remoteDataSource.getFavoriteMovies(token, page: _currentPage, pageSize: _pageSize);
      final movies = models.map((e) => e.toEntity()).toList();
      _favoriteMovies.addAll(movies);
      _hasMore = movies.length == _pageSize;
    } catch (e) {
      _error = e.toString();
      _hasMore = false;
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
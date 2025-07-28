import 'package:flutter/material.dart';
import '../../../data/storage/favorites_storage.dart';
import '../../../domain/entities/movie.dart';

class ProfileViewModel extends ChangeNotifier {
  final FavoritesStorage _favoritesStorage;

  ProfileViewModel(this._favoritesStorage);

  List<Movie> _favoriteMovies = [];
  List<Movie> get favoriteMovies => _favoriteMovies;

  void loadFavorites() {
    final favorites = _favoritesStorage.getFavorites();
    _favoriteMovies = favorites.map((fav) => Movie(
      id: fav.id,
      title: fav.title,
      description: fav.overview,
      imageUrl: fav.posterPath != null ? 'https://image.tmdb.org/t/p/w500${fav.posterPath}' : null,
    )).toList().reversed.toList();
    notifyListeners();
  }
}
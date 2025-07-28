import 'package:hive/hive.dart';
import '../models/movie_model.dart';

class FavoritesStorage {
  static const String boxName = 'favorites';

  Box<MovieModel> get _box => Hive.box<MovieModel>(boxName);

  Future<void> addFavorite(MovieModel movie) async {
    // Aynı film eklenmesin
    if (!_box.values.any((m) => m.id == movie.id)) {
      await _box.add(movie);
    }
  }

  Future<void> removeFavorite(int movieId) async {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k)?.id == movieId,
      orElse: () => null,
    );
    if (key != null) await _box.delete(key);
  }

  List<MovieModel> getFavorites() {
    return _box.values.toList();
  }

  bool isFavorite(int movieId) {
    return _box.values.any((m) => m.id == movieId);
  }
}


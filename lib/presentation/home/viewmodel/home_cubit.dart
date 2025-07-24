import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/movie_repository.dart';
import '../../../domain/entities/movie.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRepository movieRepository;
  final Random _random = Random();
  bool _isLoadingMore = false;
  final List<Movie> _allMovies = [];

  HomeCubit(this.movieRepository) : super(HomeInitial());

  Future<void> fetchMovies({bool loadMore = false}) async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    if (!loadMore) {
      emit(HomeLoading());
      _allMovies.clear();
    }

    try {
      int randomPage = _random.nextInt(500) + 1;
      final movies = await movieRepository.getMovies(randomPage);
      _allMovies.addAll(movies);
      emit(HomeLoaded(List.from(_allMovies)));
    } catch (e) {
      emit(HomeError('Hata: $e'));
    } finally {
      _isLoadingMore = false;
    }
  }
}
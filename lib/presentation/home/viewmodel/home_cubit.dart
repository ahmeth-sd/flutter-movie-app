import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/movie_repository.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_page_result.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRepository movieRepository;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoadingMore = false;
  final List<Movie> _allMovies = [];

  HomeCubit(this.movieRepository) : super(HomeInitial());

  Future<void> fetchMovies({bool loadMore = false}) async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    if (!loadMore) {
      emit(HomeLoading());
      _allMovies.clear();
      _currentPage = 1;
    } else {
      if (_currentPage >= _totalPages) {
        _isLoadingMore = false;
        return;
      }
      _currentPage++;
    }

    try {
      final pageResult = await movieRepository.getMoviesPageResult(_currentPage);
      _totalPages = pageResult.totalPages;
      _allMovies.addAll(pageResult.movies);
      emit(HomeLoaded(MoviePageResult(
        movies: List.from(_allMovies),
        currentPage: _currentPage,
        totalPages: _totalPages,
      )));
    } catch (e) {
      emit(HomeError('Hata: $e'));
    } finally {
      _isLoadingMore = false;
    }
  }
}
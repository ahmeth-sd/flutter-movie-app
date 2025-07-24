import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';
import 'movie_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRepository movieRepository;
  HomeCubit(this.movieRepository) : super(HomeInitial());

  Future<void> fetchMovies() async {
    emit(HomeLoading());
    try {
      final movies = await movieRepository.getMovies(1);
      emit(HomeLoaded(movies));
    } catch (e) {
      emit(HomeError('Hata: $e'));
    }
  }
}

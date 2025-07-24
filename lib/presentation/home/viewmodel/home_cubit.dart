import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_movies_usecase.dart';
import '../../../domain/entities/movie.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMoviesUseCase getMoviesUseCase;

  HomeCubit(this.getMoviesUseCase) : super(HomeInitial());

  Future<void> fetchMovies() async {
    emit(HomeLoading());
    try {
      final movies = await getMoviesUseCase(1);
      emit(HomeLoaded(movies));
    } catch (e) {
      emit(HomeError('Hata: $e'));
    }
  }
}
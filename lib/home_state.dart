import 'movie_repository.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<Movie> movies;
  HomeLoaded(this.movies);
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

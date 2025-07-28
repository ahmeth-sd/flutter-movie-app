import '../../../domain/entities/movie_page_result.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final MoviePageResult pageResult;

  HomeLoaded(this.pageResult);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
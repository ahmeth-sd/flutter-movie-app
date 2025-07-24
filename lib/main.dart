import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shartflix_movie_app/presentation/home/view/discover_page.dart';
import 'data/repositories/movie_repository.dart';
import 'domain/usecases/get_movies_usecase.dart';
import 'presentation/home/viewmodel/home_cubit.dart';
import 'presentation/home/view/home_page.dart';

void main() {
  final dio = Dio();
  final movieRepository = MovieRepository(dio);
  final getMoviesUseCase = GetMoviesUseCase(movieRepository);

  runApp(MyApp(getMoviesUseCase: getMoviesUseCase));
}

class MyApp extends StatelessWidget {
  final GetMoviesUseCase getMoviesUseCase;
  const MyApp({super.key, required this.getMoviesUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shartflix Demo',
      home: BlocProvider(
        create: (_) => HomeCubit(getMoviesUseCase)..fetchMovies(),
        child: DiscoverPage(), // const kaldırıldı
      ),
    );
  }
}
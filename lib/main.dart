import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shartflix_movie_app/presentation/home/view/discover_page.dart';
import 'data/repositories/movie_repository.dart';
import 'presentation/home/viewmodel/home_cubit.dart';

void main() {
  final dio = Dio();
  final movieRepository = MovieRepository(dio);

  runApp(MyApp(movieRepository: movieRepository));
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;
  const MyApp({super.key, required this.movieRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shartflix Demo',
      home: BlocProvider(
        create: (_) => HomeCubit(movieRepository)..fetchMovies(),
        child: DiscoverPage(),
      ),
    );
  }
}
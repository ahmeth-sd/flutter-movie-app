import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'movie_repository.dart';
import 'home_cubit.dart';
import 'home_page.dart';

void main() {
  final movieRepository = MovieRepository(Dio());
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
        child: const HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shartflix_movie_app/presentation/home/view/home_page.dart';
import 'package:shartflix_movie_app/presentation/home/view/discover_page.dart';
import 'package:shartflix_movie_app/presentation/home/view/profile_page.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/home_cubit.dart';
import 'package:shartflix_movie_app/presentation/home/viewmodel/navigation_vievmodel.dart';
import 'package:shartflix_movie_app/presentation/home/widgets/custom_bottom_navbar.dart';
import 'package:shartflix_movie_app/data/repositories/movie_repository.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shartflix_movie_app/data/models/movie_model.dart';
import 'package:shartflix_movie_app/data/storage/favorites_storage.dart';
import 'package:shartflix_movie_app/domain/entities/movie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.openBox<MovieModel>('favorites');

  final dio = Dio();
  final movieRepository = MovieRepository(dio);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
        BlocProvider(create: (_) => HomeCubit(movieRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatelessWidget {
  MainScaffold();

  List<Movie> _getFavoriteMovies() {
    final favorites = FavoritesStorage().getFavorites();
    return favorites.map((fav) => Movie(
      id: fav.id,
      title: fav.title,
      description: fav.overview,
      imageUrl: fav.posterPath != null ? 'https://image.tmdb.org/t/p/w500${fav.posterPath}' : null,
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavigationViewModel>().currentIndex;
    final List<Widget> _screens = [
      HomePage(),
      ProfilePage(favoriteMovies: _getFavoriteMovies()),
    ];
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
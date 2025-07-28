import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';
import '../../../data/storage/favorites_storage.dart';
import '../../../data/models/movie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  List<bool> liked = [];
  final FavoritesStorage _favoritesStorage = FavoritesStorage();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onScroll);
    context.read<HomeCubit>().fetchMovies();
  }

  void _onScroll() {
    final cubit = context.read<HomeCubit>();
    final state = cubit.state;
    if (state is HomeLoaded) {
      if (_pageController.page != null &&
          _pageController.page!.round() >= state.movies.length - 1) {
        cubit.fetchMovies(loadMore: true);
      }
    }
  }

  Future<void> _toggleLike(int index, movie) async {
    setState(() {
      liked[index] = !liked[index];
    });
    if (liked[index]) {
      final movieModel = MovieModel(
        id: movie.id,
        title: movie.title,
        overview: movie.description,
        posterPath: movie.imageUrl != null && movie.imageUrl!.contains('/w500')
            ? movie.imageUrl!.replaceFirst('https://image.tmdb.org/t/p/w500', '')
            : movie.imageUrl,
      );
      await _favoritesStorage.addFavorite(movieModel);
    } else {
      await _favoritesStorage.removeFavorite(movie.id);
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<HomeCubit>().fetchMovies();
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              final movies = state.movies;
              if (liked.length != movies.length) {
                liked = List<bool>.generate(
                  movies.length,
                      (i) => _favoritesStorage.isFavorite(movies[i].id),
                );
              }
              return PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie.imageUrl ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie.description ?? 'Açıklama yok',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 450,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: IconButton(
                            icon: Icon(
                              liked[index] ? Icons.favorite : Icons.favorite_border,
                              color: liked[index] ? Colors.red : Colors.white,
                              size: 30,
                            ),
                            onPressed: () => _toggleLike(index, movie),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
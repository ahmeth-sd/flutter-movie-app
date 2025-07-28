import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';
import '../widgets/movie_card.dart';
import '../../../data/storage/favorites_storage.dart';
import '../../../data/models/movie_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MovieModel> favorites;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchMovies();
    favorites = FavoritesStorage().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    favorites = FavoritesStorage().getFavorites();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popüler Filmler'),
      ),
      body: Column(
        children: [
          // Favori filmler yatay liste
          SizedBox(
            height: 140,
            child: favorites.isEmpty
                ? Center(child: Text('Favori film yok'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final fav = favorites[index];
                      return Container(
                        width: 100,
                        margin: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            fav.posterPath != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${fav.posterPath}',
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.movie, size: 60),
                            SizedBox(height: 4),
                            Text(
                              fav.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Divider(),
          // Popüler filmler
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: state.movies[index]);
                    },
                  );
                } else if (state is HomeError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Hoş geldiniz!'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          context.read<HomeCubit>().fetchMovies();
        }),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
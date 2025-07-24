import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popüler Filmler'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomeCubit>().fetchMovies(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
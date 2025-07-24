import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: movie.imageUrl != null
            ? Image.network(movie.imageUrl!)
            : Icon(Icons.movie),
        title: Text(movie.title),
        subtitle: Text(movie.description ?? 'Açıklama yok'),
      ),
    );
  }
}
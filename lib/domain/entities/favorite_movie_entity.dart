class FavoriteMovieEntity {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;

  FavoriteMovieEntity({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });
}


class Movie {
  final int id;
  final String title;
  final String? description;
  final String? imageUrl;

  Movie({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });
}
import '../../domain/entities/favorite_movie_entity.dart';

class FavoriteMovieModel {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;

  FavoriteMovieModel({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) {
    return FavoriteMovieModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      title: json['title'] ?? json['name'] ?? '',
      description: json['description'] ?? json['overview'] ?? '',
      imageUrl: json['imageUrl'] ?? json['posterUrl'] ?? json['posterPath'] ?? json['poster_path'] ?? '',    );
  }

  FavoriteMovieEntity toEntity() {
    return FavoriteMovieEntity(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

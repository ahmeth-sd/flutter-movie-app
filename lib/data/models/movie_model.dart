import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final String id;

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'Poster')
  final String posterUrl;

  @JsonKey(name: 'Plot')
  final String description;

  const MovieModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.description,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  Movie toEntity() => Movie(
    id: int.tryParse(id) ?? id.hashCode,
    title: title,
    imageUrl: posterUrl,
    description: description,
  );
}
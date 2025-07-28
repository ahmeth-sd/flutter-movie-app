// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: json['id'] as String,
      title: json['Title'] as String,
      posterUrl: json['Poster'] as String,
      description: json['Plot'] as String,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Title': instance.title,
      'Poster': instance.posterUrl,
      'Plot': instance.description,
    };

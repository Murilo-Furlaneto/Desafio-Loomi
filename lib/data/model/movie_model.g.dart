// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      genre: json['genre'] as String,
      posterUrl: json['posterUrl'] as String,
      availableUntil: json['availableUntil'] as String,
      commentsCount: (json['commentsCount'] as num).toInt(),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'genre': instance.genre,
      'posterUrl': instance.posterUrl,
      'availableUntil': instance.availableUntil,
      'commentsCount': instance.commentsCount,
    };

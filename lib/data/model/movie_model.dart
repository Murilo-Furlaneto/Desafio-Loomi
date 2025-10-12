import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;
  final String description;
  final String genre;
  final String posterUrl;
  final String availableUntil;
  final int commentsCount;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.posterUrl,
    required this.availableUntil,
    required this.commentsCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

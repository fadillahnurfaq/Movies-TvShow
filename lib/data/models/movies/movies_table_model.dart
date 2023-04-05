import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/movie_detail_entity.dart';

import '../../../domain/entities/movie_entity.dart';

class MovieTableModel extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? voteAverage;
  final String? releaseDate;
  final String? voteCount;

  const MovieTableModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.voteCount,
  });

  factory MovieTableModel.fromEntity(MovieDetailEntity movie) =>
      MovieTableModel(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        voteAverage: movie.voteAverage.toString(),
        releaseDate: movie.releaseDate,
        voteCount: movie.voteCount.toString(),
      );

  factory MovieTableModel.fromMap(Map<String, dynamic> map) => MovieTableModel(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        voteAverage: map['voteAverage'],
        releaseDate: map['releaseDate'],
        voteCount: map['voteCount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'voteAverage': voteAverage,
        'releaseDate': releaseDate,
        'voteCount': voteCount,
      };

  MovieEntity toEntity() => MovieEntity.watchlist(
        id: id,
        voteAverage: double.parse(voteAverage ?? "0"),
        posterPath: posterPath,
        title: title,
        releaseDate: releaseDate,
        voteCount: int.parse(voteCount ?? "0"),
      );

  @override
  List<Object?> get props =>
      [id, title, posterPath, voteAverage, voteCount, releaseDate];
}

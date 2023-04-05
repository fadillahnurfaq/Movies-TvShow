import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  const MovieEntity.watchlist({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.overview,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalTitle,
    this.popularity,
    this.video,
  });

  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}

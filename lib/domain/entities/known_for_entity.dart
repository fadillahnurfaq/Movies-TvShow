import 'package:equatable/equatable.dart';

class KnownForEntity extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int? id;
  final String? mediaType;
  final String? name;
  final List<dynamic>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final dynamic voteAverage;
  final int? voteCount;
  final bool? adult;
  final String? originalTitle;
  final String? releaseDate;
  final String? title;
  final bool? video;

  const KnownForEntity(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genreIds,
      required this.id,
      required this.mediaType,
      required this.name,
      this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount,
      required this.adult,
      required this.originalTitle,
      required this.releaseDate,
      required this.title,
      required this.video});

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        mediaType,
        name,
        originCountry,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
        adult,
        originalTitle,
        releaseDate,
        title,
        video,
      ];
}

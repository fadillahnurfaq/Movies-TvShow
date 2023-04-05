import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/known_for_entity.dart';

class KnownForModel extends Equatable {
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

  const KnownForModel(
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

  factory KnownForModel.fromJson(Map<String, dynamic> json) => KnownForModel(
        backdropPath: json['backdrop_path'],
        firstAirDate: json['first_air_date'],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json['id'],
        mediaType: json['media_type'],
        name: json['name'],
        // originCountry: List<dynamic>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        adult: json['adult'],
        originalTitle: json['original_title'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
      );

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'first_air_date': firstAirDate,
        'genre_ids': genreIds,
        'id': id,
        'media_type': mediaType,
        'name': name,
        'origin_country': originCountry,
        'original_language': originalLanguage,
        'original_name': originalName,
        'overview': overview,
        'poster_path': posterPath,
        'vote_average': voteAverage,
        'vote_count': voteCount,
        'adult': adult,
        'original_title': originalTitle,
        'release_date': releaseDate,
        'title': title,
        'video': video,
      };

  KnownForEntity toEntity() => KnownForEntity(
        backdropPath: backdropPath,
        firstAirDate: firstAirDate,
        genreIds: genreIds,
        id: id,
        mediaType: mediaType,
        name: name,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
        adult: adult,
        originalTitle: originalTitle,
        releaseDate: releaseDate,
        title: title,
        video: video,
      );

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

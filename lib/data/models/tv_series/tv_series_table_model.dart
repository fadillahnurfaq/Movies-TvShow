import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series/tv_series_detail_entity.dart';
import '../../../domain/entities/tv_series/tv_series_entity.dart';

class TvSeriesTableModel extends Equatable {
  final int id;
  final String? name;
  final String? firstAirDate;
  final String? voteAverage;
  final String? voteCount;
  final String? posterPath;

  const TvSeriesTableModel({
    required this.id,
    required this.name,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
  });

  factory TvSeriesTableModel.fromEntity(TvSeriesDetailEntity tvSeries) =>
      TvSeriesTableModel(
        id: tvSeries.id,
        name: tvSeries.name,
        firstAirDate: tvSeries.firstAirDate,
        voteAverage: tvSeries.voteAverage.toString(),
        voteCount: tvSeries.voteCount.toString(),
        posterPath: tvSeries.posterPath.toString(),
      );

  factory TvSeriesTableModel.fromMap(Map<String, dynamic> map) =>
      TvSeriesTableModel(
        id: map['id'],
        name: map['name'],
        firstAirDate: map['firstAirDate'],
        voteAverage: map['voteAverage'],
        voteCount: map['voteCount'],
        posterPath: map['posterPath'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'firstAirDate': firstAirDate,
        'voteAverage': voteAverage,
        'voteCount': voteCount,
        'posterPath': posterPath,
      };

  TvSeriesEntity toEntity() => TvSeriesEntity.watchlist(
        id: id,
        name: name,
        firstAirDate: firstAirDate,
        voteAverage: double.parse(voteAverage ?? "0"),
        voteCount: int.parse(voteCount ?? "0"),
        posterPath: posterPath,
      );

  @override
  List<Object?> get props =>
      [id, name, firstAirDate, voteAverage, voteCount, posterPath];
}

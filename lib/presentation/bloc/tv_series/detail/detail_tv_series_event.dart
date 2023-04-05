part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();

  @override
  List<Object?> get props => [];
}

class GetDetailTvSeriesEvent extends DetailTvSeriesEvent {
  final int id;

  const GetDetailTvSeriesEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistTvSeriesEvent extends DetailTvSeriesEvent {
  final TvSeriesDetailEntity tvSeriesDetail;

  const AddWatchlistTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class RemoveFromWatchlistTvSeriesEvent extends DetailTvSeriesEvent {
  final TvSeriesDetailEntity tvSeriesDetail;

  const RemoveFromWatchlistTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class LoadWatchlistStatusMovieEvent extends DetailTvSeriesEvent {
  final int id;

  const LoadWatchlistStatusMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}

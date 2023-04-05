part of 'airing_today_tv_series_bloc.dart';

abstract class AiringTodayTvSeriesState extends Equatable {
  const AiringTodayTvSeriesState();

  @override
  List<Object?> get props => [];
}

class AiringTodayTvSeriesInitialState extends AiringTodayTvSeriesState {}

class AiringTodayTvSeriesLoadingState extends AiringTodayTvSeriesState {}

class AiringTodayTvSeriesHasDataState extends AiringTodayTvSeriesState {
  final List<TvSeriesEntity> result;

  const AiringTodayTvSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class AiringTodayTvSeriesErrorState extends AiringTodayTvSeriesState {
  final String message;

  const AiringTodayTvSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

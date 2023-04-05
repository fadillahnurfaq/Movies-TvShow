part of 'on_the_air_tv_series_bloc.dart';

abstract class OnTheAirTvSeriesState extends Equatable {
  const OnTheAirTvSeriesState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvSeriesInitialState extends OnTheAirTvSeriesState {}

class OnTheAirTvSeriesLoadingState extends OnTheAirTvSeriesState {}

class OnTheAirTvSeriesErrorState extends OnTheAirTvSeriesState {
  final String message;

  const OnTheAirTvSeriesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTvSeriesHasDataState extends OnTheAirTvSeriesState {
  final List<TvSeriesEntity> result;

  const OnTheAirTvSeriesHasDataState(this.result);

  @override
  List<Object> get props => [result];
}

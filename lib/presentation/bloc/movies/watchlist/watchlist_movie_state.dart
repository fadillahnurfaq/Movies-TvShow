part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieInitialState extends WatchlistMovieState {}

class WatchlistMovieEmptyState extends WatchlistMovieState {}

class WatchlistMovieLoadingState extends WatchlistMovieState {}

class WatchlistMovieErrorState extends WatchlistMovieState {
  final String message;

  const WatchlistMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMovieHasDataState extends WatchlistMovieState {
  final List<MovieEntity> result;

  const WatchlistMovieHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

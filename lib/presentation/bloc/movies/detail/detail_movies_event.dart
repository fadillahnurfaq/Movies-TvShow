part of 'detail_movies_bloc.dart';

abstract class DetailMoviesEvent extends Equatable {
  const DetailMoviesEvent();

  @override
  List<Object?> get props => [];
}

class GetDetailMoviesEvent extends DetailMoviesEvent {
  final int id;

  const GetDetailMoviesEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistMovieEvent extends DetailMoviesEvent {
  final MovieDetailEntity movieDetail;

  const AddWatchlistMovieEvent(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchlistMovieEvent extends DetailMoviesEvent {
  final MovieDetailEntity movieDetail;

  const RemoveFromWatchlistMovieEvent(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchlistStatusMovieEvent extends DetailMoviesEvent {
  final int id;

  const LoadWatchlistStatusMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}

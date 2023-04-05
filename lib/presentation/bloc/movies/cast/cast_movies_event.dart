part of 'cast_movies_bloc.dart';

abstract class CastMoviesEvent extends Equatable {
  const CastMoviesEvent();

  @override
  List<Object?> get props => [];
}

class GetCastMovieEvent extends CastMoviesEvent {
  final int id;

  const GetCastMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}

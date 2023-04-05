part of 'cast_movies_bloc.dart';

abstract class CastMoviesState extends Equatable {
  const CastMoviesState();

  @override
  List<Object?> get props => [];
}

class CastMoviesInitialState extends CastMoviesState {}

class CastMoviesEmptyState extends CastMoviesState {}

class CastMoviesLoadingState extends CastMoviesState {}

class CastMoviesHasDataState extends CastMoviesState {
  final List<CastEntity> result;

  const CastMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class CastMoviesErrorState extends CastMoviesState {
  final String message;

  const CastMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

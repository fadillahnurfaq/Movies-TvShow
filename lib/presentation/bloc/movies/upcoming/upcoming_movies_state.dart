part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object?> get props => [];
}

class UpcomingMoviesInitialState extends UpcomingMoviesState {}

class UpcomingMoviesLoadingState extends UpcomingMoviesState {}

class UpcomingMoviesHasDataState extends UpcomingMoviesState {
  final List<MovieEntity> result;

  const UpcomingMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class UpcomingMoviesErrorState extends UpcomingMoviesState {
  final String message;

  const UpcomingMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class SearchMoviesOnQueryChangedEvent extends SearchMoviesEvent {
  final String query;

  const SearchMoviesOnQueryChangedEvent(this.query);

  @override
  List<Object> get props => [query];
}

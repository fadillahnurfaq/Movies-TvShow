part of 'popular_people_bloc.dart';

abstract class PopularPeopleState extends Equatable {
  const PopularPeopleState();

  @override
  List<Object?> get props => [];
}

class PopularPeopleInitialState extends PopularPeopleState {}

class PopularPeopleLoadingState extends PopularPeopleState {}

class PopularPeopleHasDataState extends PopularPeopleState {
  final List<PopularPeopleEntity> result;

  const PopularPeopleHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularPeopleErrorState extends PopularPeopleState {
  final String message;

  const PopularPeopleErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

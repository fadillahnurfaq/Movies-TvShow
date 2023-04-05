import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/popular_people_entity.dart';
import 'package:movies_app/domain/usecase/people/get_popular_people.dart';

part 'popular_people_event.dart';
part 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  final GetPopularPeople _getPopularPeople;
  PopularPeopleBloc(this._getPopularPeople)
      : super(PopularPeopleInitialState()) {
    on<PopularPeopleEvent>((event, emit) async {
      if (event is GetPopularPeopleEvent) {
        emit(PopularPeopleLoadingState());

        final result = await _getPopularPeople.execute();
        result.fold((failure) => emit(PopularPeopleErrorState(failure.message)),
            (data) {
          if (data.isEmpty) {
            emit(PopularPeopleInitialState());
          } else {
            emit(PopularPeopleHasDataState(data));
          }
        });
      }
    });
  }
}

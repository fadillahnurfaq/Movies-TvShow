import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/usecase/movies/get_upcoming_movies.dart';

import '../../../../domain/entities/movie_entity.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final GetUpcomingMovies _getUpcomingMovies;
  UpcomingMoviesBloc(this._getUpcomingMovies)
      : super(UpcomingMoviesInitialState()) {
    on<UpcomingMoviesEvent>((event, emit) async {
      if (event is GetUpcomingMoviesEvent) {
        final result = await _getUpcomingMovies.execute();

        result
            .fold((failure) => emit(UpcomingMoviesErrorState(failure.message)),
                (data) {
          if (data.isEmpty) {
            emit(UpcomingMoviesInitialState());
          } else {
            emit(UpcomingMoviesHasDataState(data));
          }
        });
      }
    });
  }
}

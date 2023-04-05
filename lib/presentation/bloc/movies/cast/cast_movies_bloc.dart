import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/cast_entity.dart';
import '../../../../domain/usecase/movies/get_cast_movies.dart';

part 'cast_movies_event.dart';
part 'cast_movies_state.dart';

class CastMoviesBloc extends Bloc<CastMoviesEvent, CastMoviesState> {
  final GetCastMovies _getCastMovies;
  CastMoviesBloc(this._getCastMovies) : super(CastMoviesInitialState()) {
    on<CastMoviesEvent>((event, emit) async {
      if (event is GetCastMovieEvent) {
        emit(CastMoviesLoadingState());
        final result = await _getCastMovies.execute(event.id);

        result.fold((failure) => emit(CastMoviesErrorState(failure.message)),
            (data) {
          if (data.isEmpty) {
            emit(CastMoviesEmptyState());
          } else {
            emit(CastMoviesHasDataState(data));
          }
        });
      }
    });
  }
}

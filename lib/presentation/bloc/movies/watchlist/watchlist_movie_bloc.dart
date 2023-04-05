import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/domain/usecase/movies/get_watchlist_movie.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._getWatchlistMovies)
      : super(WatchlistMovieInitialState()) {
    on<WatchlistMovieEvent>((event, emit) async {
      if (event is GetWatchlistMovieEvent) {
        emit(WatchlistMovieLoadingState());

        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) => emit(WatchlistMovieErrorState(failure.message)),
          (data) {
            if (data.isEmpty) {
              emit(WatchlistMovieEmptyState());
            } else {
              emit(WatchlistMovieHasDataState(data));
            }
          },
        );
      }
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/movie_detail_entity.dart';
import 'package:movies_app/domain/usecase/movies/get_detail_movies.dart';

import '../../../../domain/usecase/movies/get_watchlist_status_movie.dart';
import '../../../../domain/usecase/movies/remove_watchlist_movie.dart';
import '../../../../domain/usecase/movies/save_watchlist_movie.dart';
import '../../../../utils/state_enum.dart';

part 'detail_movies_event.dart';
part 'detail_movies_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMovieState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final GetDetailMovie getDetailMovie;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;
  final GetWatchListStatusMovie getWatchListStatusMovie;

  DetailMoviesBloc({
    required this.getDetailMovie,
    required this.getWatchListStatusMovie,
    required this.removeWatchlistMovie,
    required this.saveWatchlistMovie,
  }) : super(DetailMovieState.initial()) {
    on<DetailMoviesEvent>((event, emit) async {
      if (event is GetDetailMoviesEvent) {
        // emit(DetailMoviesLoadingState());
        emit(state.copyWith(movieDetailState: RequestState.loading));
        final id = event.id;
        final detailMovieResult = await getDetailMovie.execute(id);

        detailMovieResult.fold(
          (failure) => emit(
            state.copyWith(
              movieDetailState: RequestState.error,
              message: failure.message,
            ),
          ),
          (movieDetail) => emit(
            state.copyWith(
              movieDetailState: RequestState.loaded,
              movieDetail: movieDetail,
              watchlistMessage: '',
            ),
          ),
        );
      }

      if (event is AddWatchlistMovieEvent) {
        final movieDetail = event.movieDetail;
        final result = await saveWatchlistMovie.execute(movieDetail);

        result.fold(
          (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
          (successMessage) =>
              emit(state.copyWith(watchlistMessage: successMessage)),
        );

        add(LoadWatchlistStatusMovieEvent(movieDetail.id));
      }

      if (event is RemoveFromWatchlistMovieEvent) {
        final movieDetail = event.movieDetail;
        final result = await removeWatchlistMovie.execute(movieDetail);

        result.fold(
          (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
          (successMessage) =>
              emit(state.copyWith(watchlistMessage: successMessage)),
        );

        add(LoadWatchlistStatusMovieEvent(movieDetail.id));
      }

      if (event is LoadWatchlistStatusMovieEvent) {
        final status = await getWatchListStatusMovie.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: status));
      }
    });
  }
}

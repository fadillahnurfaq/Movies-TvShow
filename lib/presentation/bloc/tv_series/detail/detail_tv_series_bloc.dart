import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/usecase/tv_series/get_watchlist_status_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/remove_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/save_watchlist_tv_series.dart';

import '../../../../domain/entities/tv_series/tv_series_detail_entity.dart';
import '../../../../domain/usecase/tv_series/get_detail_tv_series.dart';
import '../../../../utils/state_enum.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final GetDetailTvSeries getDetailTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  DetailTvSeriesBloc({
    required this.getDetailTvSeries,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
    required this.getWatchListStatusTvSeries,
  }) : super(DetailTvSeriesState.initial()) {
    on<DetailTvSeriesEvent>((event, emit) async {
      if (event is GetDetailTvSeriesEvent) {
        emit(state.copyWith(tvSeriesDetailState: RequestState.loading));

        final id = event.id;
        final detailTvSeriesResult = await getDetailTvSeries.execute(id);

        detailTvSeriesResult.fold(
          (failure) => emit(
            state.copyWith(
              tvSeriesDetailState: RequestState.error,
              message: failure.message,
            ),
          ),
          (tvSeriesDetail) => emit(
            state.copyWith(
              tvSeriesDetailState: RequestState.loaded,
              tvSeriesDetail: tvSeriesDetail,
              watchlistMessage: '',
            ),
          ),
        );
      }

      if (event is AddWatchlistTvSeriesEvent) {
        final tvSeriesDetail = event.tvSeriesDetail;
        final result = await saveWatchlistTvSeries.execute(tvSeriesDetail);

        result.fold(
          (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
          (successMessage) =>
              emit(state.copyWith(watchlistMessage: successMessage)),
        );

        add(LoadWatchlistStatusMovieEvent(tvSeriesDetail.id));
      }

      if (event is RemoveFromWatchlistTvSeriesEvent) {
        final tvSeriesDetail = event.tvSeriesDetail;
        final result = await removeWatchlistTvSeries.execute(tvSeriesDetail);

        result.fold(
          (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
          (successMessage) =>
              emit(state.copyWith(watchlistMessage: successMessage)),
        );

        add(LoadWatchlistStatusMovieEvent(tvSeriesDetail.id));
      }

      if (event is LoadWatchlistStatusMovieEvent) {
        final status = await getWatchListStatusTvSeries.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: status));
      }
    });
  }
}

part of 'detail_tv_series_bloc.dart';

class DetailTvSeriesState extends Equatable {
  final TvSeriesDetailEntity? tvSeriesDetail;
  final RequestState tvSeriesDetailState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  const DetailTvSeriesState({
    required this.tvSeriesDetail,
    required this.tvSeriesDetailState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  DetailTvSeriesState copyWith({
    TvSeriesDetailEntity? tvSeriesDetail,
    RequestState? tvSeriesDetailState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return DetailTvSeriesState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory DetailTvSeriesState.initial() {
    return const DetailTvSeriesState(
      tvSeriesDetail: null,
      tvSeriesDetailState: RequestState.empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        tvSeriesDetail,
        tvSeriesDetailState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}

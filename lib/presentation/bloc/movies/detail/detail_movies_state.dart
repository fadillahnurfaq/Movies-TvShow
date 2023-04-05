part of 'detail_movies_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetailEntity? movieDetail;
  final RequestState movieDetailState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const DetailMovieState({
    required this.movieDetail,
    required this.movieDetailState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object?> get props {
    return [
      movieDetail,
      movieDetailState,
      message,
      watchlistMessage,
      isAddedToWatchlist,
    ];
  }

  DetailMovieState copyWith({
    MovieDetailEntity? movieDetail,
    RequestState? movieDetailState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return DetailMovieState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory DetailMovieState.initial() {
    return const DetailMovieState(
      movieDetail: null,
      movieDetailState: RequestState.empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }
}


// class DetailMoviesInitialState extends DetailMoviesState {}

// class DetailMoviesLoadingState extends DetailMoviesState {}

// class DetailMoviesErrorState extends DetailMoviesState {
//   final String message;

//   const DetailMoviesErrorState(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class DetailMoviesHasDataState extends DetailMoviesState {
//   final MovieDetailEntity result;

//   const DetailMoviesHasDataState(this.result);

//   @override
//   List<Object?> get props => [result];
// }

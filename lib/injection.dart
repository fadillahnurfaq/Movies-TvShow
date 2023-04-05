import 'package:get_it/get_it.dart';
import 'package:movies_app/data/datasources/people/people_remote_data_source.dart';
import 'package:movies_app/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:movies_app/data/repositories/tv_repository_impl.dart';
import 'package:movies_app/domain/repositories/people_repository.dart';
import 'package:movies_app/domain/repositories/tv_series_repository.dart';
import 'package:movies_app/domain/usecase/movies/get_cast_movies.dart';
import 'package:movies_app/domain/usecase/movies/get_detail_movies.dart';
import 'package:movies_app/domain/usecase/movies/get_now_playing_movies.dart';
import 'package:movies_app/domain/usecase/movies/get_popular_movies.dart';
import 'package:movies_app/domain/usecase/movies/get_search_movies.dart';
import 'package:movies_app/domain/usecase/movies/get_top_rated_movies.dart';
import 'package:movies_app/domain/usecase/movies/get_upcoming_movies.dart';
import 'package:movies_app/domain/usecase/movies/get_watchlist_movie.dart';
import 'package:movies_app/domain/usecase/movies/get_watchlist_status_movie.dart';
import 'package:movies_app/domain/usecase/movies/remove_watchlist_movie.dart';
import 'package:movies_app/domain/usecase/movies/save_watchlist_movie.dart';
import 'package:movies_app/domain/usecase/people/get_popular_people.dart';
import 'package:movies_app/domain/usecase/tv_series/get_airing_today_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/get_detail_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/get_on_the_air_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/get_popular_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/get_search_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/get_top_rated_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/get_watchlist_status_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/get_watchlist_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/remove_tv_series.dart';
import 'package:movies_app/domain/usecase/tv_series/save_watchlist_tv_series.dart';
import 'package:movies_app/presentation/bloc/movies/cast/cast_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/detail/detail_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/now_playing/now_playing_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/popular/popular_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/search/search_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/top_rated/top_rated_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/upcoming/upcoming_movies_bloc.dart';
import 'package:movies_app/presentation/bloc/movies/watchlist/watchlist_movie_bloc.dart';
import 'package:movies_app/presentation/bloc/people/popular/popular_people_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/airing_today/airing_today_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/detail/detail_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/on_the_air/on_the_air_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/search/search_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import 'package:movies_app/presentation/bloc/tv_series/watchlist/watchlist_tv_series_bloc.dart';
import 'package:movies_app/presentation/cubit/main_navigation_cubit.dart';
import 'package:movies_app/presentation/cubit/movies/tab_detail_movie_cubit.dart';
import 'package:movies_app/presentation/cubit/tab_selected_cubit.dart';
import 'package:movies_app/presentation/cubit/tv_series/tab_detail_tv_series_cubit.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movies/movies_local_data_source.dart';
import 'data/datasources/movies/movies_remote_data_source.dart';
import 'data/datasources/tv_series/tv_series_local_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'data/repositories/people_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'utils/http_ssl_painning.dart';

final locator = GetIt.instance;

void init() {
  // Cubit
  locator.registerFactory(() => MainNavigationCubit());
  locator.registerFactory(() => TabSelectedCubit());
  locator.registerFactory(() => TabDetailMovieCubit());
  locator.registerFactory(() => TabDetailTvSeriesCubit());

  // Bloc Movies
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => UpcomingMoviesBloc(locator()));
  locator.registerFactory(() => DetailMoviesBloc(
      getDetailMovie: locator(),
      getWatchListStatusMovie: locator(),
      removeWatchlistMovie: locator(),
      saveWatchlistMovie: locator()));
  locator.registerFactory(() => CastMoviesBloc(locator()));
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));

  // Bloc Tvseries
  locator.registerFactory(() => AiringTodayTvSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTvSeriesBloc(locator()));
  locator.registerFactory(() => OnTheAirTvSeriesBloc(locator()));
  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => WatchlistTvSeriesBloc(locator()));
  locator.registerFactory(() => SearchTvSeriesBloc(locator()));
  locator.registerFactory(() => DetailTvSeriesBloc(
        getDetailTvSeries: locator(),
        getWatchListStatusTvSeries: locator(),
        removeWatchlistTvSeries: locator(),
        saveWatchlistTvSeries: locator(),
      ));

  // Bloc people
  locator.registerFactory(() => PopularPeopleBloc(locator()));

  // Usecase Movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetUpcomingMovies(locator()));
  locator.registerLazySingleton(() => GetDetailMovie(locator()));
  locator.registerLazySingleton(() => GetCastMovies(locator()));
  locator.registerLazySingleton(() => GetSearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));

  // Usecase TvSeries
  locator.registerLazySingleton(() => GetAiringTodayTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetSearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));

  // Usecase People
  locator.registerLazySingleton(() => GetPopularPeople(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<PeopleRepository>(
    () => PeopleRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MoviesRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<PeopleRemoteDataSource>(
      () => PeopleRemoteDataSourceImpl(client: locator()));

  // Database Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}

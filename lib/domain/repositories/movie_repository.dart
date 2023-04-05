import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/entities/movie_detail_entity.dart';

import '../../utils/failure.dart';
import '../entities/cast_entity.dart';
import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopular();
  Future<Either<Failure, List<MovieEntity>>> getNowPlaying();
  Future<Either<Failure, List<MovieEntity>>> getTopRated();
  Future<Either<Failure, List<MovieEntity>>> getUpcoming();
  Future<Either<Failure, MovieDetailEntity>> getDetail(int id);
  Future<Either<Failure, List<CastEntity>>> getCast(int id);
  Future<Either<Failure, List<MovieEntity>>> search(String query);
  Future<Either<Failure, List<MovieEntity>>> getWatchlist();
  Future<Either<Failure, String>> saveWatchlist(MovieDetailEntity movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetailEntity movie);
  Future<bool> isAddedToWatchlist(int id);
}

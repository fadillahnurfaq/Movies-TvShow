import 'dart:io';

import 'package:movies_app/domain/entities/movie_detail_entity.dart';
import 'package:movies_app/utils/failure.dart';

import 'package:movies_app/domain/entities/movie_entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/entities/cast_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../utils/exception.dart';
import '../datasources/movies/movies_local_data_source.dart';
import '../datasources/movies/movies_remote_data_source.dart';
import '../models/movies/movies_table_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getNowPlaying() async {
    try {
      final result = await remoteDataSource.getNowPlaying();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopular() async {
    try {
      final result = await remoteDataSource.getPopular();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopRated() async {
    try {
      final result = await remoteDataSource.getTopRated();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getUpcoming() async {
    try {
      final result = await remoteDataSource.getUpcoming();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getDetail(int id) async {
    try {
      final result = await remoteDataSource.getDetail(id);
      return right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<CastEntity>>> getCast(int id) async {
    try {
      final result = await remoteDataSource.getCast(id);
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> search(String query) async {
    try {
      final result = await remoteDataSource.search(query);

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getWatchlist() async {
    try {
      final result = await localDataSource.getWatchlist();
      return Right(result.map((data) => data.toEntity()).toList());
    } on DatabaseException catch (e) {
      return left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetailEntity movie) async {
    try {
      final result = await localDataSource
          .insertWatchList(MovieTableModel.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      MovieDetailEntity movie) async {
    try {
      final result = await localDataSource
          .removeWatchList(MovieTableModel.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getWatchlistById(id);

    return result != null;
  }
}

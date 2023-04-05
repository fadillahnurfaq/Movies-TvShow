import 'dart:io';

import 'package:movies_app/data/datasources/people/people_remote_data_source.dart';
import 'package:movies_app/domain/entities/popular_people_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/repositories/people_repository.dart';
import 'package:movies_app/utils/failure.dart';

import '../../utils/exception.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource remoteDataSource;

  PeopleRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<PopularPeopleEntity>>> getPopularPeople() async {
    try {
      final result = await remoteDataSource.getPopularPeople();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }
}

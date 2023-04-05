import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/entities/movie_detail_entity.dart';

import '../../../utils/failure.dart';

import '../../repositories/movie_repository.dart';

class GetDetailMovie {
  final MovieRepository repository;

  GetDetailMovie(this.repository);

  Future<Either<Failure, MovieDetailEntity>> execute(int id) {
    return repository.getDetail(id);
  }
}

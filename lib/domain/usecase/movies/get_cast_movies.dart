import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/cast_entity.dart';
import '../../repositories/movie_repository.dart';

class GetCastMovies {
  final MovieRepository repository;

  GetCastMovies(this.repository);

  Future<Either<Failure, List<CastEntity>>> execute(int id) {
    return repository.getCast(id);
  }
}

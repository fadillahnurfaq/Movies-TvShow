import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/entities/movie_detail_entity.dart';
import '../../../utils/failure.dart';

import '../../repositories/movie_repository.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetailEntity movie) {
    return repository.removeWatchlist(movie);
  }
}

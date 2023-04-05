import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/entities/movie_detail_entity.dart';

import '../../../utils/failure.dart';

import '../../repositories/movie_repository.dart';

class SaveWatchlistMovie {
  final MovieRepository repository;

  SaveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetailEntity movie) {
    return repository.saveWatchlist(movie);
  }
}

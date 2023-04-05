import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/repositories/tv_series_repository.dart';

import '../../../utils/failure.dart';
import '../../entities/tv_series/tv_series_entity.dart';

class GetAiringTodayTvSeries {
  final TvSeriesRepository repository;

  GetAiringTodayTvSeries(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute() {
    return repository.getAiringToday();
  }
}

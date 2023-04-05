import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/entities/popular_people_entity.dart';

import '../../utils/failure.dart';

abstract class PeopleRepository {
  Future<Either<Failure, List<PopularPeopleEntity>>> getPopularPeople();
}

import 'package:dartz/dartz.dart';
import 'package:movies_app/domain/repositories/people_repository.dart';

import '../../../utils/failure.dart';
import '../../entities/popular_people_entity.dart';

class GetPopularPeople {
  final PeopleRepository repository;

  GetPopularPeople(this.repository);

  Future<Either<Failure, List<PopularPeopleEntity>>> execute() {
    return repository.getPopularPeople();
  }
}

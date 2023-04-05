import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/known_for_entity.dart';

class PopularPeopleEntity extends Equatable {
  final bool? adult;
  final int? gender;
  final int? id;
  final List<KnownForEntity>? knownFor;
  final String? knownForDepartment;
  final String? name;
  final double? popularity;
  final String? profilePath;

  const PopularPeopleEntity(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownFor,
      required this.knownForDepartment,
      required this.name,
      required this.popularity,
      required this.profilePath});

  @override
  List<Object?> get props => [
        adult,
        gender,
        id,
        knownFor,
        knownForDepartment,
        name,
        popularity,
        profilePath,
      ];
}

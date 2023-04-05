import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/popular_people_entity.dart';

import 'known_for_model.dart';

class PopularPeopleModel extends Equatable {
  final bool? adult;
  final int? gender;
  final int? id;
  final List<KnownForModel>? knownFor;
  final String? knownForDepartment;
  final String? name;
  final double? popularity;
  final String? profilePath;

  const PopularPeopleModel(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownFor,
      required this.knownForDepartment,
      required this.name,
      required this.popularity,
      required this.profilePath});

  factory PopularPeopleModel.fromJson(Map<String, dynamic> json) =>
      PopularPeopleModel(
        adult: json['adult'],
        gender: json['gender'],
        id: json['id'],
        knownFor: List<KnownForModel>.from(
            json["known_for"].map((x) => KnownForModel.fromJson(x))),
        knownForDepartment: json['known_for_department'],
        name: json['name'],
        popularity: json['popularity'],
        profilePath: json['profile_path'],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "know_for": knownFor,
        "known_for_department": knownForDepartment,
        "name": name,
        "popularity": popularity,
        "profile_path": profilePath,
      };

  PopularPeopleEntity toEntity() => PopularPeopleEntity(
      adult: adult,
      gender: gender,
      id: id,
      knownFor: knownFor?.map((genre) => genre.toEntity()).toList(),
      knownForDepartment: knownForDepartment,
      name: name,
      popularity: popularity,
      profilePath: profilePath);

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

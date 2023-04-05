import 'package:equatable/equatable.dart';
import 'package:movies_app/data/models/people/popular_people_model.dart';

class PopularPeopleResponseModel extends Equatable {
  final List<PopularPeopleModel> peopleList;

  const PopularPeopleResponseModel({required this.peopleList});

  factory PopularPeopleResponseModel.fromJson(Map<String, dynamic> json) =>
      PopularPeopleResponseModel(
        peopleList: List<PopularPeopleModel>.from((json["results"] as List)
            .map((x) => PopularPeopleModel.fromJson(x))
            .where((element) => element.profilePath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(peopleList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [peopleList];
}

import 'dart:convert';

import 'package:movies_app/data/models/people/popular_people_model.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/models/people/popular_people_response_model.dart';

import '../../../utils/constant.dart';
import '../../../utils/exception.dart';

abstract class PeopleRemoteDataSource {
  Future<List<PopularPeopleModel>> getPopularPeople();
}

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final http.Client client;

  PeopleRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PopularPeopleModel>> getPopularPeople() async {
    final response =
        await client.get(Uri.parse("$baseUrl/person/popular?$apiKey"));
    if (response.statusCode == 200) {
      return PopularPeopleResponseModel.fromJson(jsonDecode(response.body))
          .peopleList;
    } else {
      throw ServerException();
    }
  }
}

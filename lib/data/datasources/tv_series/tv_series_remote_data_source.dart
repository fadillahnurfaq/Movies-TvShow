import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';
import '../../../utils/exception.dart';
import '../../models/tv_series/tv_series_detail_response_model.dart';
import '../../models/tv_series/tv_series_model.dart';
import '../../models/tv_series/tv_series_response_model.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnTheAir();
  Future<List<TvSeriesModel>> getPopular();
  Future<List<TvSeriesModel>> getTopRated();
  Future<List<TvSeriesModel>> getAiringToday();
  Future<TvSeriesDetailResponseModel> getDetail(int id);
  Future<List<TvSeriesModel>> search(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getOnTheAir() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopular() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRated() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getAiringToday() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponseModel> getDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> search(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}

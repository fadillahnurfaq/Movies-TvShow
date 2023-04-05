
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/constant.dart';
import '../../../utils/exception.dart';
import '../../models/movies/cast_model.dart';
import '../../models/movies/cast_response_model.dart';
import '../../models/movies/movies_detail_response_model.dart';
import '../../models/movies/movies_model.dart';
import '../../models/movies/movies_response_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MoviesModel>> getNowPlaying();
  Future<List<MoviesModel>> getPopular();
  Future<List<MoviesModel>> getTopRated();
  Future<List<MoviesModel>> getUpcoming();
  Future<MovieDetailResponseModel> getDetail(int id);
  Future<List<CastModel>> getCast(int id);
  Future<List<MoviesModel>> search(String query);
}

class MovieRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MoviesModel>> getNowPlaying() async {
    final response =
        await client.get(Uri.parse("$baseUrl/movie/now_playing?$apiKey"));
    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesModel>> getPopular() async {
    final response =
        await client.get(Uri.parse("$baseUrl/movie/popular?$apiKey"));
    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesModel>> getTopRated() async {
    final response =
        await client.get(Uri.parse("$baseUrl/movie/top_rated?$apiKey"));
    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesModel>> getUpcoming() async {
    final response =
        await client.get(Uri.parse("$baseUrl/movie/upcoming?$apiKey"));
    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesModel>> search(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponseModel> getDetail(int id) async {
    final response = await client.get(Uri.parse("$baseUrl/movie/$id?$apiKey"));
    if (response.statusCode == 200) {
      return MovieDetailResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CastModel>> getCast(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/$id/credits?$apiKey'));
    if (response.statusCode == 200) {
      return CastResponseModel.fromJson(jsonDecode(response.body)).castList;
    } else {
      throw ServerException();
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:q_movie_app/data/api_repository.dart';
import 'package:q_movie_app/data/models/ganres.dart';
import 'package:q_movie_app/data/models/movie_details.dart';
import 'package:q_movie_app/data/models/movies_list.dart';
import 'package:q_movie_app/utils/strings.dart';

class ApiRepositoryImpl extends ApiRepository {
  late Dio _dio;

  static BaseOptions options = BaseOptions(
    baseUrl: AppStrings.baseUrl,
    contentType: 'application/json; charset=utf-8',
  );

  ApiRepositoryImpl() {
    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (!options.headers.containsKey('Authorization') &&
          AppStrings.accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${AppStrings.accessToken}';
      }
      debugPrint('REQUEST[${options.method}] => PATH: ${options.path} '
          '=> Request Values: ${options.queryParameters}, => HEADERS: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      debugPrint('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
      return handler.next(response);
    }, onError: (err, handler) {
      debugPrint('ERROR[${err.response?.statusCode}]');
      return handler.next(err);
    }));
  }

  @override
  Future<Genres> getGenresList({
    String language = 'en_US',
  }) async {
    try {
      var response = await _dio.get(
        '/3/genre/movie/list',
        queryParameters: {
          "language": language,
        },
      );
      return Genres.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<MoviesList> getPopularMovies({
    String language = 'en_US',
    required int page,
  }) async {
    try {
      var response = await _dio.get('/3/movie/popular', queryParameters: {
        "language": "language",
        "page": page,
      });
      return MoviesList.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<MovieDetails> getMovie(int movieId,
      {String language = 'en_US', int page = 1}) async {
    try {
      var response = await _dio.get(
        '/3/movie/$movieId',
        queryParameters: {
          "language": language,
          "page": page,
        },
      );
      return MovieDetails.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

import 'dart:convert';
import 'package:{{name.snakeCase()}}/presentation/modules/home/controller.dart';
import 'package:dio/dio.dart';

import '../../app/core/values/languages/translations.dart';
import '../core/error/server_exception.dart';
import '../utils/domain.dart';

abstract class HttpClient {
  Future<dynamic> get(String url,
      {Map<String, dynamic> headers,
      Map<String, dynamic>? queryParameters,
      bool authorization = false});
  Future<dynamic> post(String url,
      {Map headers, required body, bool authorization = false});
  Future<dynamic> put(String url,
      {Map headers, required body, bool authorization = false});
}

class HttpClientImpl implements HttpClient {
  late Dio _dio;

  HttpClientImpl() {
    _initApiClient();
  }

  void _initApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: Domain.api,
      receiveTimeout: 30000,
      connectTimeout: 30000,
      responseType: ResponseType.plain,
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          return handler.next(options);
        },
        onResponse: (Response response, handler) async {
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic>? queryParameters,
    bool authorization = false,
  }) async {
    _dio.options.baseUrl = Domain.api;
    try {
      if (authorization) {
        _dio.options.headers["authorization"] = HomeController.to.accessToken;
      }

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {..._dio.options.headers, ...headers},
        ),
      );

      return response.data;
    } on DioError catch (e) {
      throwError(e);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Map headers = const {},
    required body,
    bool authorization = false,
  }) async {
    _dio.options.baseUrl = Domain.api;
    try {
      if (authorization) {
        _dio.options.headers["authorization"] = HomeController.to.accessToken;
      }

      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {..._dio.options.headers, ...headers},
        ),
      );

      return response.data;
    } on DioError catch (e) {
      throwError(e);
    }
  }


  @override
  Future put(
    String url, {
    Map headers = const {},
    required body,
    bool authorization = false,
  }) async {
    _dio.options.baseUrl = Domain.api;
    try {
      if (authorization) {
        _dio.options.headers["authorization"] = HomeController.to.accessToken;
      }

      final response = await _dio.put(
        url,
        data: body,
        options: Options(
          headers: {..._dio.options.headers, ...headers},
        ),
      );

      return response.data;
    } on DioError catch (e) {
      throwError(e);
    }
  }

  throwError(DioError e) {
    if (e.response?.data != null) {
      throw ServerException(json.decode(e.response?.data)["message"]);
    }

    throw ServerException(AppTranslations.connectFailed);
  }
}

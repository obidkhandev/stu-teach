import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/dio_interceptor.dart';
import 'package:stu_teach/core/api/list_api.dart';


typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient  {
  // String? _auth;
  late Dio _dio;

  DioClient(SharedPreferences preferences) {
    _dio = _createDio();

    try {
      _dio.interceptors.add(MySmartDioInterceptor(preferences));
    } catch (e) {
      debugPrint('SE:$e');
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }
  }

  Dio get dio {
    final dio = _createDio();

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true, requestBody: true, requestHeader: true));
    }
    return dio;
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: ListAPI.BASE_URL,
        
          receiveTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 30),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters, Options? options,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters,options: options);
      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      if (response.statusCode == 204) {
        return true;
      }
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? headers,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: options ?? Options(headers: headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String url, {
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    try {
      final response =
          await _dio.patch(url, data: data, options: Options(headers: headers));
      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    try {
      final response =
          await _dio.put(url, data: data, options: Options(headers: headers));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return response;
    } on DioException {
      rethrow;
    }
  }
}

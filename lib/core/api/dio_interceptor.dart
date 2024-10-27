import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/list_api.dart';

class MySmartDioInterceptor extends Interceptor {
  MySmartDioInterceptor(this._preferences);
  final SharedPreferences _preferences;
  // final Dio _dio;
  // String _refresh = '';

  String _token = '';
  String? _lang;
  List<Map<dynamic, dynamic>> _failedRequests = [];
  bool _isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    // _refresh = StorageService.to.getRefreshToken();
    _token = _preferences.getString(ListAPI.ACCESS_TOKEN) ?? "";
    _lang = _preferences.getString(ListAPI.LANG);

    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['accept-language'] = _lang ?? 'uz';

    if (_token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $_token";
    }
    debugPrint('REQUEST::${options.data}');
    handler.next(options);
  }
 
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        // DioConnectivityRequestRetry(
        //   dio: _dio,
        //   connectivity: Connectivity(),
        // ).scheduleRequestRetry(err.requestOptions);
      } catch (er) {
        handler.next(err);
      }
    }

    if (err.response?.statusCode == 401 && _token != '') {
      if (!_isRefreshing) {
        _isRefreshing = true;

        /// refresh token after it expired and get new token
        // await _refreshToken();
      }
      _failedRequests.add({'err': err, 'handler': handler});

      if (_token.isEmpty) {
        return;
      }

      /// retry request after token refreshed successfully
      await _retryRequestsAfterTokenRefresh();
    }
    handler.next(err);
  }

  /// retry all request after token refreshed successfully
  Future<void> _retryRequestsAfterTokenRefresh() async {
    final dio = Dio();
    if (_failedRequests.isNotEmpty) {
      for (int i = 0; i < _failedRequests.length; i++) {
        RequestOptions requestOptions =
            _failedRequests[i]['err'].requestOptions as RequestOptions;
        final options = Options(
          method: requestOptions.method,
          headers: {
            'Authorization': 'Token $_token',
            'Content-Type': 'application/json',
          },
        );
        late Response cloneReq;
        try {
          cloneReq = await dio.request(
            requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: options,
          );
        } catch (e) {
          debugPrint('EE:$e');
        }
        _failedRequests[i]['handler'].resolve(cloneReq);
      }
      _isRefreshing = false;
      _failedRequests = [];
    }
  }

  bool _shouldRetry(DioException err) {
    return err.error != null && err.error is SocketException;
  }

  /// Navigate to Sign in Screen if token is fail
  // Future<void> _goToLoginScreen() async {}
}

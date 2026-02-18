import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movix/core/network/api_endpoints.dart';

/// Applies the same request form to every request: Accept, Content-Type, Authorization Bearer.
/// On 401, tries to refresh the token and retries the request.
class DioInterceptor extends Interceptor {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  bool _isRefreshing = false;
  Completer <String?>? _refreshCompleter;

  final Dio dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  DioInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    final storedToken = await storage.read(key: _accessTokenKey);
    
  if (storedToken != null && storedToken.isNotEmpty) {
    options.headers['Authorization'] = 'Bearer $storedToken';
  }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final accessToken = await _refreshToken();
        if (accessToken == null) {
          await storage.deleteAll();
          handler.reject(err);
          return;
        }
        handler.resolve(await _retry(err.requestOptions, accessToken));
      } on DioException catch (e) {
        await storage.deleteAll();
        handler.reject(e);
      }
      return;
    }
    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    if (_isRefreshing) {
      return _refreshCompleter?.future;
    } else {
      _isRefreshing = true;
      _refreshCompleter = Completer<String?>();
      try {
        final newToken = await performTokenRefresh();
        _refreshCompleter?.complete(newToken);
        return newToken;
      } catch (e) {
        _refreshCompleter?.completeError(e);
        rethrow;
      } finally {
        _isRefreshing = false;
      }
    }    
  }

  Future<String?> performTokenRefresh() async {
   final refreshToken = await storage.read(key: _refreshTokenKey);
    if (refreshToken == null) return null;
    try {
      final response = await dio.post(
        ApiEndpoints.refreshToken,
        options: Options(headers: {'Refresh-Token': refreshToken}),
      );

      if (response.statusCode != 200 || response.data == null) return null;


      final data = response.data as Map<String, dynamic>;

      final newAccessToken = data['accessToken'] as String?;
      final newRefreshToken = data['refreshToken'] as String?;
      if (newAccessToken != null) {
        await storage.write(key: _accessTokenKey, value: newAccessToken);
      }
      if (newRefreshToken != null) {
        await storage.write(key: _refreshTokenKey, value: newRefreshToken);
      }
      return newAccessToken;
    } on DioException catch (e) {
      debugPrint('Refresh token failed: ${e.message}');
    return null;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions, String accessToken) async {
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }
}

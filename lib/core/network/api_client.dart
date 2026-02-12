import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movix/core/network/api_endpoints.dart';

class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
  });
}

/// Main API Client - Follows Interface Segregation Principle
/// Provides clean methods for all API operations
class ApiClient {
  late final Dio _dio;

  ApiClient({String? token}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    // _dio.interceptors.add(ApiInterceptor(token: token));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ));
    }
  }

  /// Update authorization token
  void updateToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Remove authorization token
  void removeToken() {
    _dio.options.headers.remove('Authorization');
  }

  // ============== HELPER METHODS ==============

  /// Generic GET request handler
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Generic POST request handler
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Generic PUT request handler
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Generic DELETE request handler
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Helper to send a rating for a film. Pass the full endpoint path.
  Future<ApiResponse<T>> sendRating<T>(
    String endpoint,
    double rating, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extraFields,
  }) async {
    final payload = <String, dynamic>{'rating': rating};
    if (extraFields != null) payload.addAll(extraFields);
    return post<T>(endpoint, data: payload, headers: headers);
  }

  /// Handle successful response
  ApiResponse<T> _handleResponse<T>(Response response) {
    String? message;

    try {
      if (response.data is Map && (response.data as Map).containsKey('message')) {
        message = (response.data as Map)['message']?.toString();
      } else if (response.statusMessage != null && response.statusMessage!.isNotEmpty) {
        message = response.statusMessage;
      } else {
        message = 'Success';
      }
    } catch (_) {
      message = response.statusMessage ?? 'Success';
    }

    final dynamic respData = response.data;

    return ApiResponse<T>(
      success: true,
      message: message,
      data: respData as T?,
      statusCode: response.statusCode,
    );
  }

  /// Handle error response
  ApiResponse<T> _handleError<T>(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiResponse<T>(
            success: false,
            message: 'Connection timeout. Please check your internet.',
            statusCode: 408,
          );

        case DioExceptionType.badResponse:
          String? serverMessage;
          try {
            final d = error.response?.data;
            log(d.toString());
            if (d is Map && d.containsKey('message')) {
              serverMessage = d['message']?.toString();
            } else if (d is String) {
              serverMessage = d;
            }
          } catch (_) {
            serverMessage = null;
          }

          return ApiResponse<T>(
            success: false,
            message: serverMessage ?? 'Server error occurred',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.cancel:
          return ApiResponse<T>(
            success: false,
            message: 'Request cancelled',
            statusCode: 499,
          );

        default:
          return ApiResponse<T>(
            success: false,
            message: 'Network error. Please try again.',
            statusCode: 500,
          );
      }
    }

    return ApiResponse<T>(
      success: false,
      message: error.toString(),
      statusCode: 500,
    );
  }
}
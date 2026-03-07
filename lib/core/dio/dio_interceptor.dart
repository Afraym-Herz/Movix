import 'dart:async';
import 'package:dio/dio.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/services/secure_storage.dart';

/// Applies the same request form to every request: Accept, Content-Type, Authorization Bearer.
/// On 401, tries to refresh the token and retries the request.
class DioInterceptor extends Interceptor {
  

  final Dio dio;
   SecureStorage storage = const SecureStorage();

  DioInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    const storedToken = ApiEndpoints.apiReadAccessToken;
    
    options.headers['Authorization'] = 'Bearer $storedToken';
  

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
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

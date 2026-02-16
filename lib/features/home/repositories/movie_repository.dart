import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/features/home/models/movie_response.dart';

abstract class MovieRepository {
  Future<MovieResponse> getTopRatedMovies({int page = 1});
  Future<MovieResponse> getPopularMovies({int page = 1});
  Future<MovieResponse> getTrendingMovies({int page = 1});

}

class MovieRepositoryImpl implements MovieRepository {
  final ApiClient _apiClient;

  MovieRepositoryImpl(this._apiClient);

  @override
  Future<MovieResponse> getTopRatedMovies({int page = 1}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.topRated,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return MovieResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load top rated movies');
    }
  }
  
  @override
  Future<MovieResponse> getPopularMovies({int page = 1} ) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.popular,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return MovieResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load popular movies');
    }
  }
  
  @override
  Future<MovieResponse> getTrendingMovies({int page = 1}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.trending,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return MovieResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load trending movies');
    }
  }

}

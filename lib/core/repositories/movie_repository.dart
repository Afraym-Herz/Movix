import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/features/home/models/movie_response.dart';

abstract class MovieRepository {
  Future<MovieResponse> getTopRatedMovies({required int page});
  Future<MovieResponse> getPopularMovies({required int page});
  Future<MovieResponse> getTrendingMovies({required int page});
  Future<MovieResponse> getRecommendedMovies({
    required int movieId,
    required int page,
  });
  Future<MovieResponse> exploreMethod({required String category, required int page});
}

class MovieRepositoryImpl implements MovieRepository {
  final ApiClient _apiClient;

  MovieRepositoryImpl(this._apiClient);

  @override
  Future<MovieResponse> getTopRatedMovies({required int page}) async {
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
  Future<MovieResponse> getPopularMovies({required int page}) async {
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
  Future<MovieResponse> getTrendingMovies({required int page}) async {
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
  
  @override
  Future<MovieResponse> exploreMethod({required String category, required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.discoverMovies(category),
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return MovieResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load explore movies');
    }
  }
  
  @override
  Future<MovieResponse> getRecommendedMovies({required int movieId, required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.recommendations(movieId),
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return MovieResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load recommended movies');
    }
  }
}

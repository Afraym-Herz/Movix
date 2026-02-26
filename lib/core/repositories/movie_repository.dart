import 'package:movix/core/models/show.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/models/show_response.dart';

abstract class MovieRepository {
  Future<ShowResponse> getTopRatedMovies({required int page});
  Future<ShowResponse> getPopularMovies({required int page});
  Future<ShowResponse> getTrendingMovies({required int page});
  Future<ShowResponse> getNowPlayingMovies({required int page});
  Future<ShowResponse> getUpComingMovies({required int page});
  

  Future<ShowResponse> getRecommendedMovies({
    required int movieId,
    required int page,
  });
  Future<ShowResponse> exploreMethod({required String category, required int page});
}

class MovieRepositoryImpl implements MovieRepository {
  final ApiClient _apiClient;

  MovieRepositoryImpl(this._apiClient);

  @override
  Future<ShowResponse> getTopRatedMovies({required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.topRatedMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return ShowResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load top rated movies');
    }
  }

  @override
  Future<ShowResponse> getPopularMovies({required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.popularMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return ShowResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load popular movies');
    }
  }

  @override
  Future<ShowResponse> getTrendingMovies({required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.trendingMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return ShowResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load trending movies');
    }
  }
  
  @override
  Future<ShowResponse> exploreMethod({required String category, required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.discoverMovies(category),
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return ShowResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load explore movies');
    }
  }
  
  @override
  Future<ShowResponse> getRecommendedMovies({required int movieId, required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.recommendationsMovies(movieId),
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return ShowResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load recommended movies');
    }
  }
  
  @override
  Future<ShowResponse> getNowPlayingMovies({required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.nowPlayingMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return ShowResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load popular movies');
    }
  }
  
  @override
  Future<ShowResponse> getUpComingMovies({required int page}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.upComingMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return ShowResponse.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load popular movies');
    }
  }
}

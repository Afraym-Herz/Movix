import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/features/movies/models/movie_response.dart';
import 'package:movix/features/movies/models/movie_details.dart';

abstract class MovieRepository {
  Future<MovieResponse> getTopRatedMovies({int page = 1});
  Future<MovieDetails> getMovieDetails(int movieId);
}

class MovieRepositoryImpl implements MovieRepository {
  final ApiClient _apiClient;

  MovieRepositoryImpl(this._apiClient);

  @override
  Future<MovieResponse> getTopRatedMovies({int page = 1}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/3/movie/top_rated',
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
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/3/movie/$movieId',
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
      },
    );

    if (response.success && response.data != null) {
      return MovieDetails.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load movie details');
    }
  }
}

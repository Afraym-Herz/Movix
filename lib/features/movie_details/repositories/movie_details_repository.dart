import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';

abstract class MovieDetailsRepository {
    Future<MovieDetailsModel> getMovieDetails(int movieId);

}

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final ApiClient _apiClient;

  MovieDetailsRepositoryImpl(this._apiClient);

 
  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/3/movie/$movieId',
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
      },
    );

    if (response.success && response.data != null) {
      return MovieDetailsModel.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load movie details');
    }
  }
}
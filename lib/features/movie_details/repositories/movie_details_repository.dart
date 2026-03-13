import 'package:dartz/dartz.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';
import 'package:movix/features/movie_details/models/rating_response.dart';

abstract class MovieDetailsRepository {
    Future<MovieDetailsModel> getMovieDetails(int movieId);
  Future<Either<String, RatingResponse>> addMovieRating({
    required int movieId,
    required double rating,
  });
}

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final ApiClient _apiClient;

  MovieDetailsRepositoryImpl(this._apiClient, SecureStorage secureStorage);

 
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

  @override
  Future<Either<String, RatingResponse>> addMovieRating({
    required int movieId,
    required double rating,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/3/movie/$movieId/rating',
      data: {'value': rating},
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
      },
    );

    if (response.success && response.data != null) {
      return Right(RatingResponse.fromJson(response.data!));
    } else {
      return Left(response.message ?? 'Failed to add rating');
    }
  }
}
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsModel> getMovieDetails(int movieId);
  Future<Either<Failure, String>> addMovieRating({
    required MovieDetailsModel movie,
    required double rating,
  });

  Future<Either<Failure, String>> removeMovieRating({required int movieId});

  Future<String?> getMovieRating(int movieId);
}

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final ApiClient _apiClient;
  final SecureStorage secureStorage;

  MovieDetailsRepositoryImpl(this._apiClient, this.secureStorage);

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.movieDetails(movieId),
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
    );

    if (response.success && response.data != null) {
      return MovieDetailsModel.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load movie details');
    }
  }  

  @override
  Future<Either<Failure, String>> addMovieRating({
    required MovieDetailsModel movie,
    required double rating,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.ratingMovies(movie.id),
      data: {'value': rating},
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
    );

    if (response.success && response.data != null) {
      log(" $rating is added ${response.data!['status_message']}");
      await secureStorage.setUserRatingMovie(movie.id, rating);
      await secureStorage.saveRatedItem(show: movie, userRating: rating);

      return Right(response.data!['status_message']);
    } else {
      return Left(
        ServerFailure(message: response.message ?? 'Failed to add rating'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> removeMovieRating({
    required int movieId,
  }) async {
    final response = await _apiClient.delete<Map<String, dynamic>>(
      ApiEndpoints.ratingMovies(movieId),
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
    );

    if (response.success && response.data != null) {
      await secureStorage.deleteRatedItem(movieId);
      return Right(response.data!['status_message']);
    } else {
      return Left(
        ServerFailure(message: response.message ?? 'Failed to remove rating'),
      );
    }
  }

  @override
  Future<String?> getMovieRating(int movieId) async {
    return await secureStorage.getUserRatingMovie(movieId);
  }
}
  

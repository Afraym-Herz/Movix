import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

abstract class TVSeriesDetailsRepository {
  Future<Either<Failure, TVSeriesDetailsModel>> getTVSeriesDetails(int tvSeriesId);
  Future<Either<Failure, String>> addTVSeriesRating({
    required TVSeriesDetailsModel tvSeries,
    required double rating,
  });

  Future<Either<Failure, String>> removeTVSeriesRating({required int tvSeriesId});

  Future<String?> getTVSeriesRating(int tvSeriesId);
}

class TVSeriesDetailsRepositoryImpl implements TVSeriesDetailsRepository {
  final ApiClient _apiClient;
  final SecureStorage secureStorage;

  TVSeriesDetailsRepositoryImpl(this._apiClient, this.secureStorage);

  @override
  Future<Either<Failure, TVSeriesDetailsModel>> getTVSeriesDetails(int tvSeriesId) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.tvSeriesDetails(tvSeriesId),
        queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
      );

      if (response.success && response.data != null) {
        
        return Right(TVSeriesDetailsModel.fromJson(response.data!));
      } else {
        return Left(
          ServerFailure(message: response.message ?? 'Failed to load TV series details'),
        );
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addTVSeriesRating({
    required TVSeriesDetailsModel tvSeries,
    required double rating,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      // Note: This endpoint might need to be verified in ApiEndpoints
      ApiEndpoints.ratingTVSeries(tvSeries.id), 
      data: {'value': rating},
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
    );

    if (response.success && response.data != null) {
      log(" $rating is added to tv series ${response.data!['status_message']}");
      await secureStorage.setUserRatingTVSeries(tvSeries.id, rating);
      await secureStorage.saveRatedItem(show: tvSeries, userRating: rating);

      return Right(response.data!['status_message']);
    } else {
      return Left(
        ServerFailure(message: response.message ?? 'Failed to add rating'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> removeTVSeriesRating({
    required int tvSeriesId,
  }) async {
    final response = await _apiClient.delete<Map<String, dynamic>>(
       // Note: This endpoint might need to be verified in ApiEndpoints
      ApiEndpoints.ratingTVSeries(tvSeriesId),
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
    );

    if (response.success && response.data != null) {
      await secureStorage.deleteRatedItem(tvSeriesId);
      return Right(response.data!['status_message']);
    } else {
      return Left(
        ServerFailure(message: response.message ?? 'Failed to remove rating'),
      );
    }
  }

  @override
  Future<String?> getTVSeriesRating(int tvSeriesId) async {
    return await secureStorage.getUserRatingTVSeries(tvSeriesId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

abstract class TVSeriesDetailsRepository {
  Future<TVSeriesDetailsModel> getTVSeriesDetails(int tvSeriesId);
  Future<Either<Failure, String>> addTVSeriesRating({
    required int tvSeriesId,
    required double rating,
  });
  Future<Either<Failure, String>> removeTVSeriesRating({
    required int tvSeriesId,
  });

  Future<String?> getTVSeriesRating(int tvSeriesId);
}

class TVSeriesDetailsRepositoryImpl implements TVSeriesDetailsRepository {
  final ApiClient _apiClient;
  final SecureStorage _secureStorage;

  TVSeriesDetailsRepositoryImpl(this._apiClient, this._secureStorage);

  @override
  Future<TVSeriesDetailsModel> getTVSeriesDetails(int tvSeriesId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.tvSeriesDetails(tvSeriesId),
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
    );

    if (response.success && response.data != null) {
      return TVSeriesDetailsModel.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load tvSeries details');
    }
  }

  @override
  Future<Either<Failure, String>> addTVSeriesRating({
    required int tvSeriesId,
    required double rating,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.ratingMovies(tvSeriesId),
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
      data: {'value': rating},
    );
    if (response.success && response.data != null) {
      _secureStorage.setUserRatingTVSeries(tvSeriesId, rating);

      return Right(response.data!['status_message']);
    } else {
      return Left(
        ServerFailure(message: response.message ?? 'Failed to add rating'),
      );
    }
  }
  
  @override
  Future<Either<Failure, String>> removeTVSeriesRating({required int tvSeriesId}) async {
    final response =  await _apiClient.delete<Map<String, dynamic>>(
      ApiEndpoints.ratingMovies(tvSeriesId),
      queryParameters: {'api_key': ApiEndpoints.apiKey, 'language': 'en-US'},
    );
    if (response.success && response.data != null) {
      _secureStorage.deleteUserRatingTVSeries(tvSeriesId);
      return Right(response.data!['status_message']);
    } else {
      return Left(
        ServerFailure(message: response.message ?? 'Failed to remove rating'),
      );
    }
   
  }
  
  @override
  Future<String?> getTVSeriesRating(int tvSeriesId) {
    return _secureStorage.getUserRatingTVSeries(tvSeriesId);
  }
}

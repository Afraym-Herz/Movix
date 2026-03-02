import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/models/tv_series_model.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/models/tv_series_response.dart';

abstract class TVSeriesRepository {
  Future<Either<TvSeriesResponse, Failure>> getTopRatedTVSeries({
    required int page,
  });
  Future<Either<TvSeriesResponse, Failure>> getPopularTVSeries({
    required int page,
  });
  Future<Either<TvSeriesResponse, Failure>> getAiringTodayTVSeries({
    required int page,
  });
  Future<Either<TvSeriesResponse, Failure>> getOnTheAirTVSeries({
    required int page,
  });
  Future<Either<TvSeriesResponse, Failure>> getLatestTVSeries({
    required int page,
  });

  Future<Either<TvSeriesResponse, Failure>> getRecommendedTVSeries({
    required int tvSeriesId,
    required int page,
  });
  Future<Either<TvSeriesResponse, Failure>> exploreMethod({
    required String category,
    required int page,
  });

  Future<Either<String, Failure>> addTvSeriesRating({
    required int tvSeriesId,
    required double rating,
  });
}

class TVSerieRepositoryImpl implements TVSeriesRepository {
  final ApiClient _apiClient;

  TVSerieRepositoryImpl(this._apiClient);

  @override
  Future<Either<TvSeriesResponse, Failure>> getTopRatedTVSeries({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.tvSeriesTopRated,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Left(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Right(
        ServerFailure(
          message: response.message ?? 'Failed to load top rated TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<TvSeriesResponse, Failure>> getPopularTVSeries({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.tvSeriesPopular,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Left(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Right(
        ServerFailure(
          message: response.message ?? 'Failed to load popular Tv Series',
        ),
      );
    }
  }

  @override
  Future<Either<TvSeriesResponse, Failure>> getAiringTodayTVSeries({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.airingTodayTVSeries,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Left(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Right(
        ServerFailure(
          message: response.message ?? 'Failed to load Airing today TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<TvSeriesResponse, Failure>> exploreMethod({
    required String category,
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.discoverTVSeries(category),
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Left(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Right(
        ServerFailure(
          message: response.message ?? 'Failed to load Explore TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<TvSeriesResponse, Failure>> getRecommendedTVSeries({
    required int tvSeriesId,
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.recommendationsTVSeries(tvSeriesId),
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Left(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Right(
        ServerFailure(
          message: response.message ?? 'Failed to load Recommended TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<TvSeriesResponse, Failure>> getLatestTVSeries({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.tvSeriesLatest,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Left(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Right(
        ServerFailure(
          message: response.message ?? 'Failed to load latest TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<TvSeriesResponse, Failure>> getOnTheAirTVSeries({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.tvSeriesOnTheAir,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Left(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Right(
        ServerFailure(
          message: response.message ?? 'Failed to load on the air TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<String, Failure>> addTvSeriesRating({
    required int tvSeriesId,
    required double rating,
  }) async {
    final respose = await _apiClient.sendMovieRating(tvSeriesId, rating);

    if (respose.success) {
      return Left(respose.data!['status_message']);
    }

    return Right(
      ServerFailure(message: respose.message ?? 'Failed to add rating'),
    );
  }
}

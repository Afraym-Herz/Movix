import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/models/tv_series_response.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, TvSeriesResponse>> getTopRatedTVSeries({
    required int page,
  });
  Future<Either<Failure, TvSeriesResponse>> getPopularTVSeries({
    required int page,
  });
  Future<Either<Failure, TvSeriesResponse>> getAiringTodayTVSeries({
    required int page,
  });
  Future<Either<Failure, TvSeriesResponse>> getOnTheAirTVSeries({
    required int page,
  });
  Future<Either<Failure, TvSeriesResponse>> getLatestTVSeries({
    required int page,
  });

  Future<Either<Failure, TvSeriesResponse>> getRecommendedTVSeries({
    required int tvSeriesId,
    required int page,
  });
  Future<Either<Failure, TvSeriesResponse>> exploreMethod({
    required String category,
    required int page,
  });
}

class TVSerieRepositoryImpl implements TVSeriesRepository {
  final ApiClient _apiClient;

  TVSerieRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, TvSeriesResponse>> getTopRatedTVSeries({
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
      return Right(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load top rated TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TvSeriesResponse>> getPopularTVSeries({
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
      return Right(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load popular Tv Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TvSeriesResponse>> getAiringTodayTVSeries({
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
      return Right(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Airing today TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TvSeriesResponse>> exploreMethod({
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
      return Right(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Explore TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TvSeriesResponse>> getRecommendedTVSeries({
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
      return Right(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Recommended TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TvSeriesResponse>> getLatestTVSeries({
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
      return Right(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load latest TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TvSeriesResponse>> getOnTheAirTVSeries({
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
      return Right(TvSeriesResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load on the air TV Series',
        ),
      );
    }
  }
}

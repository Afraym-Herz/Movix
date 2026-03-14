import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/models/tv_series_response.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, ShowResponse>> getTopRatedTVSeries({
    required int page,
  });
  Future<Either<Failure, ShowResponse>> getPopularTVSeries({
    required int page,
  });
  Future<Either<Failure, ShowResponse>> getAiringTodayTVSeries({
    required int page,
  });
  Future<Either<Failure, ShowResponse>> getOnTheAirTVSeries({
    required int page,
  });
  Future<Either<Failure, ShowResponse>> getLatestTVSeries({
    required int page,
  });

  Future<Either<Failure, ShowResponse>> getRecommendedTVSeries({
    required int tvSeriesId,
    required int page,
  });
  Future<Either<Failure, ShowResponse>> exploreMethod({
    required String category,
    required int page,
  });
}

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final ApiClient _apiClient;

  TVSeriesRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, ShowResponse>> getTopRatedTVSeries({
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
      return Right(ShowResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load top rated TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getPopularTVSeries({
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
      return Right(ShowResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load popular Tv Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getAiringTodayTVSeries({
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
      return Right(ShowResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Airing today TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> exploreMethod({
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
      return Right(ShowResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Explore TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getRecommendedTVSeries({
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
      return Right(ShowResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Recommended TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getLatestTVSeries({
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
      return Right(ShowResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load latest TV Series',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getOnTheAirTVSeries({
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
      return Right(ShowResponse.fromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load on the air TV Series',
        ),
      );
    }
  }
}

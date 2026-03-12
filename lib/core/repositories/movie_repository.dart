import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/models/show_response.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';

abstract class MovieRepository {
  Future<Either<Failure, ShowResponse>> getTopRatedMovies({required int page});
  Future<Either<Failure, ShowResponse>> getPopularMovies({required int page});
  Future<Either<Failure, ShowResponse>> getTrendingMovies({required int page});
  Future<Either<Failure, ShowResponse>> getNowPlayingMovies({
    required int page,
  });
  Future<Either<Failure, ShowResponse>> getUpComingMovies({required int page});

  Future<Either<Failure, ShowResponse>> getRecommendedMovies({
    required int movieId,
    required int page,
  });
  Future<Either<Failure, ShowResponse>> exploreMethod({
    required String category,
    required int page,
  });
}

class MovieRepositoryImpl implements MovieRepository {
  final ApiClient _apiClient;

  MovieRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, ShowResponse>> getTopRatedMovies({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.topRatedMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Right(ShowResponse.moviesFromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load top rated movies',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getPopularMovies({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.popularMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Right(ShowResponse.moviesFromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load popular movies',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getTrendingMovies({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.trendingMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Right(ShowResponse.moviesFromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Trending movies',
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
      ApiEndpoints.discoverMovies(category),
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Right(ShowResponse.moviesFromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Explore movies',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getRecommendedMovies({
    required int movieId,
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.recommendationsMovies(movieId),
      queryParameters: {
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Right(ShowResponse.moviesFromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Recommended movies',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getNowPlayingMovies({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.nowPlayingMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Right(ShowResponse.moviesFromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Now playing movies',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShowResponse>> getUpComingMovies({
    required int page,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.upComingMovies,
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
        'page': page,
      },
    );

    if (response.success && response.data != null) {
      return Right(ShowResponse.moviesFromJson(response.data!));
    } else {
      return Left(
        ServerFailure(
          message: response.message ?? 'Failed to load Upcoming movies',
        ),
      );
    }
  }
}

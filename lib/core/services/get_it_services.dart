import 'package:get_it/get_it.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/auth/data/repo/auth_repo.dart';
import 'package:movix/features/auth/data/repo/auth_repo_impl.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/movie_details/repositories/movie_details_repository.dart';
import 'package:movix/features/tv_series_details/repositories/tv_series_details_repository.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiClient>(ApiClient());

  getIt.registerSingleton<SecureStorage>(const SecureStorage());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      apiClient: getIt<ApiClient>(),
      secureStorage: getIt<SecureStorage>(),
    ),
  );

  getIt.registerSingleton<MovieRepository>(
    MovieRepositoryImpl(getIt<ApiClient>()),
  );

  getIt.registerSingleton<TVSeriesRepository>(
    TVSeriesRepositoryImpl(getIt<ApiClient>()),
  );

  getIt.registerSingleton<MovieDetailsRepository>(
    MovieDetailsRepositoryImpl(getIt<ApiClient>(), getIt<SecureStorage>()),
  );

  getIt.registerSingleton<TVSeriesDetailsRepository>(
    TVSeriesDetailsRepositoryImpl(getIt<ApiClient>(), getIt<SecureStorage>()),
  );
}


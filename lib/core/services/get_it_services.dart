import 'package:get_it/get_it.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/auth/data/repo/auth_repo.dart';
import 'package:movix/features/auth/data/repo/auth_repo_impl.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/profile/data/repo/profile_repo.dart';
import 'package:movix/features/profile/data/repo/profile_repo_impl.dart';
import 'package:movix/features/saved_movie/data/repo/saved_movie_repo.dart';
import 'package:movix/features/saved_movie/data/repo/saved_movie_repo_impl.dart';
import 'package:movix/features/search/data/repo/search_repo.dart';
import 'package:movix/features/search/data/repo/search_repo_impl.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiClient>(ApiClient());

  getIt.registerSingleton<SecureStorage>(SecureStorage());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      apiClient: getIt<ApiClient>(),
      secureStorage: getIt<SecureStorage>(),
    ),
  );

  getIt.registerSingleton<MovieRepository>(
    MovieRepositoryImpl(getIt<ApiClient>()),
  );

  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(apiClient: getIt<ApiClient>()),
  );

  getIt.registerSingleton<SavedMovieRepo>(
    SavedMovieRepoImpl(apiClient: getIt<ApiClient>()),
  );

  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(apiClient: getIt<ApiClient>()),
  );


}

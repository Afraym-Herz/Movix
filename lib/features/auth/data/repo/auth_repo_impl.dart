
import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/auth/data/models/user_model.dart';
import 'package:movix/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final SecureStorage secureStorage;
  final ApiClient apiClient;

  AuthRepoImpl({required this.apiClient, required this.secureStorage});

 

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiClient.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      var data = response.data;
      final UserModel userModel = UserModel(
        id: data["user"]["id"],
        name: data["user"]["name"],
        email: data["user"]["email"],
      );

      await secureStorage.writeUserData(
        key: userModel.id,
        userModel: userModel,
      );

      await secureStorage.setAccessToken(data['accessToken']);
      await secureStorage.setRefreshToken(data['refreshToken']);

      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData({
    required String userId,
  }) async {
    try {
      var response = await secureStorage.readUserData(uId: userId);

      if (response != null) {
        return Right(UserModel.fromJson(response));
      } else {
        return const Left(ServerFailure(message: 'No user data found'));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future saveUserData({required UserModel user}) async {
    await secureStorage.writeUserData(key: user.id, userModel: user);
  }

  @override
  Future<Either<Failure, String>> refreshToken() async {
    try {
      final response = await apiClient.post(ApiEndpoints.refreshToken);

      if (!response.success) {
        return const Left(ServerFailure(message: 'Failed to refresh token'));
      } else if (response.statusCode == 401) {
        return const Left(ServerFailure(message: 'Refresh token expired'));
      }

      final String newToken = response.data['accessToken'];
      await secureStorage.setAccessToken(newToken);
      await secureStorage.setRefreshToken(response.data['refreshToken']);

      apiClient.updateToken(newToken);

      return Right(newToken);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword({
    required String email,
  }) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );

      if (!response.success) {
        return Left(
          ServerFailure(message: response.message ?? "Request failed"),
        );
      }

      return Right(response.data['message']);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout({required String uId}) async {
    try {
      final response = await apiClient.post(ApiEndpoints.logout);
      if (!response.success) {
        return Left(
          ServerFailure(message: response.message ?? "Logout failed"),
        );
      }

      apiClient.removeToken();
      await secureStorage.clearTokens();
      await secureStorage.deleteUserData(uId: uId);

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String newPassword,
    required String refreshToken,
  }) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.resetPassword,
        data: {
          'email': email,
          'newPassword': newPassword,
          'token': refreshToken,
        },
      );

      if (!response.success) {
        return Left(
          ServerFailure(message: response.message ?? "Reset password failed"),
        );
      }

      return Right(response.data['message']);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    

    final accessTokenVar = await secureStorage.getAccessToken();
    final refreshTokenVar = await secureStorage.getRefreshToken();

    return (accessTokenVar != null &&
        refreshTokenVar != null );
  }
  
  @override
  Future<Either<void, String>> getUserIdFromStorage() {
    return secureStorage.getUserId().then((userId) {
      if (userId != null) {
        return Right(userId);
      } else {
        return const Left(null);
      }
    });
  }
  
  @override
  Future setUserId(String userId) {
    return secureStorage.setUserId(userId);
  }
}

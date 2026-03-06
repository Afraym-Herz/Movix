import 'dart:developer';

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
  Future<Either<Failure, String>> getRequestToken() async {
    try {
      final response = await apiClient.get(ApiEndpoints.requestToken);

      if (!response.success) {
        return const Left(ServerFailure(message: 'Failed to request token'));
      } else if (response.statusCode == 401) {
        return const Left(ServerFailure(message: 'Request token expired'));
      }

      final String newToken = response.data['request_token'];
      await secureStorage.setUserRequestToken(newToken);
      log('new token: $newToken');
      return Right(newToken);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> validateWithLogin({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiClient.post(
        ApiEndpoints.validateWithLogin,
        data: {
          'username': email,
          'password': password,
          'request_token': await secureStorage.getUserRequestToken(),
        },
      );

      var data = response.data;
      final String requestToken = data['request_token'];

      await secureStorage.setUserRequestToken(requestToken);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getSessionId() async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.createSession,
        data: {'request_token':  await secureStorage.getUserRequestToken()},
      );

      if (!response.success) {
        return const Left(ServerFailure(message: 'Failed to create session'));
      } else if (response.statusCode == 401) {
        return const Left(ServerFailure(message: 'create session expired'));
      }

      final String sessionId = response.data['session_id'];

      await secureStorage.setUserSessionId(sessionId);

      return Right(sessionId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getAccountDetails({
    required String sessionId,
  }) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.accountDetails(sessionId),
        queryParameters: {'session_id': sessionId},
      );

      if (!response.success) {
        return const Left(
          ServerFailure(message: 'Failed to get account details'),
        );
      } else if (response.statusCode == 401) {
        return const Left(
          ServerFailure(message: 'get account details expired'),
        );
      }

      final UserModel user = UserModel.fromJson(response.data);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      // Step 1: Get Request Token
      final tokenResult = await getRequestToken();
      if (tokenResult.isLeft()) {
        return Left(
          tokenResult.fold(
            (f) => f,
            (_) => const ServerFailure(message: 'request token error'),
          ),
        );
      }

      // Step 2: Validate With Login
      final validateResult = await validateWithLogin(
        email: email,
        password: password,

      );
      if (validateResult.isLeft()) {
        return Left(
          validateResult.fold(
            (f) => f,
            (_) => const ServerFailure(message: 'validate with login error'),
          ),
        );
      }

      // Step 3: Create Session
      final sessionResult = await getSessionId();
      if (sessionResult.isLeft()) {
        return Left(
          sessionResult.fold(
            (f) => f,
            (_) => const ServerFailure(message: 'create session error'),
          ),
        );
      }

      // Step 4: Get Account Details
      final sessionId = sessionResult.getOrElse(() => '');
      final accountResult = await getAccountDetails(sessionId: sessionId.toString());

      return accountResult.fold((failure) => Left(failure), (user) async {
         await secureStorage.writeUserData(userModel: user);
         await secureStorage.setUserId(user.id.toString());
        return Right(user);
      });
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData({
    required String userId,
  }) async {
    try {
      var response = await secureStorage.readUserData();

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
    await secureStorage.writeUserData(userModel: user);
  }

  @override
  Future<Either<Failure, Unit>> logout({required String uId}) async {
    try {
      final sessionId = await secureStorage.getUserSessionId();
final response = await apiClient.delete(
  ApiEndpoints.logout,
  data: {'session_id': sessionId},
);
      if (!response.success) {
        return Left(
          ServerFailure(message: response.message ?? "Logout failed"),
        );
      }

      await secureStorage.clearTokens();
      await secureStorage.deleteUserData();

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final sessionUserVar = await secureStorage.getUserSessionId();
    final requestTokenVar = await secureStorage.getUserRequestToken();

    return (sessionUserVar != null && requestTokenVar != null);
  }
}

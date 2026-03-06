import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> getRequestToken();
  
  Future<Either<Failure, void>> validateWithLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> getSessionId();

  Future<Either<Failure, UserModel>> getAccountDetails({required String sessionId});

  

  Future<Either<Failure, UserModel>> logIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout({required String uId});

  Future<Either<Failure, UserModel>> getUserData({required String userId});

  Future saveUserData({required UserModel user});

  Future<bool> isAuthenticated();
}

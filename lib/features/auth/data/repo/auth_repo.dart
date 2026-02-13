import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/features/auth/data/models/user_model.dart';

abstract class AuthRepo {

  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> refreshToken();

  Future<Either<Failure, Unit>> logout({required String uId});

  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String newPassword,
    required String refreshToken,
  });

  Future<Either<Failure, String>> forgetPassword({required String email});

  Future<Either<Failure, UserModel>> getUserData({required String userId});

  Future saveUserData({required UserModel user});

  Future<bool> isAuthenticated();

  Future<Either<void, String>> getUserIdFromStorage();

  Future setUserId(String userId);
}

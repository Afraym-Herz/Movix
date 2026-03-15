import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_state.dart';
import 'package:movix/features/auth/data/models/user_model.dart';
import 'package:movix/features/auth/data/repo/auth_repo.dart';

// ─── Mock ────────────────────────────────────────
class MockAuthRepo extends AuthRepo {
  @override
  Future<Either<Failure, String>> getRequestToken() async =>
      const Right('mock_token');

  @override
  Future<Either<Failure, void>> validateWithLogin({
    required String email,
    required String password,
  }) async => const Right(null);

  @override
  Future<Either<Failure, String>> getSessionId() async =>
      const Right('mock_session');

  @override
  Future<Either<Failure, UserModel>> getAccountDetails({
    required String sessionId,
  }) async => Right(_mockUser);

  @override
  Future<Either<Failure, UserModel>> logIn({
    required String email,
    required String password,
  }) async => Right(_mockUser);

  @override
  Future<Either<Failure, UserModel>> getUserData({
    required String userId,
  }) async => Right(_mockUser);

  @override
  Future saveUserData({required UserModel user}) async {}

  @override
  Future<Either<Failure, Unit>> logout({required String uId}) async =>
      const Right(unit);

  @override
  Future<bool> isAuthenticated() async => false;
}

// ─── Fake User ───────────────────────────────────
final _mockUser = UserModel(
  id: 1,
  username: 'testuser',
  avatarPath: '',
  language: 'en',
  country: 'US',
);

// ─── Tests ───────────────────────────────────────
void main() {
  late MockAuthRepo mockAuthRepo;
  late AuthCubit authCubit;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    authCubit = AuthCubit(mockAuthRepo);
  });

  tearDown(() {
    authCubit.close();
  });

  // ── AuthCubit Tests ──────────────────────────────
  group('AuthCubit', () {
    test('initial state is AuthInitial', () {
      expect(authCubit.state, isA<AuthInitial>());
    });

    test('logIn emits AuthLoading then AuthSuccess', () async {
      expectLater(
        authCubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthSuccess>(),
        ]),
      );

      await authCubit.signin(
        email: 'test@test.com',
        password: '123456',
      );
    });

    test('logIn emits AuthFailure on wrong credentials', () async {
      // Override to return failure
      final failRepo = _FailAuthRepo();
      final failCubit = AuthCubit(failRepo);

      expectLater(
        failCubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthFailure>(),
        ]),
      );

      await failCubit.signin(
        email: 'wrong@test.com',
        password: 'wrongpass',
      );

      failCubit.close();
    });

    test('checkAuthenticationStatus emits UnAuthenticated when no session',
        () async {
      expectLater(
        authCubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<UnAuthenticated>(),
        ]),
      );

      await authCubit.checkAuthenticationStatus();
    });

    test('currentUser returns null when not authenticated', () {
      expect(authCubit.currentUser, isNull);
    });

    test('currentUser returns user when authenticated', () async {
      await authCubit.signin(
        email: 'test@test.com',
        password: '123456',
      );
      expect(authCubit.currentUser, isNotNull);
      expect(authCubit.currentUser?.username, 'testuser');
    });
  });
}

// ─── Fail Repo for error testing ─────────────────
class _FailAuthRepo extends AuthRepo {
  @override
  Future<Either<Failure, String>> getRequestToken() async =>
      const Left(ServerFailure(message: 'Invalid credentials'));

  @override
  Future<Either<Failure, void>> validateWithLogin({
    required String email,
    required String password,
  }) async => const Left(ServerFailure(message: 'Invalid credentials'));

  @override
  Future<Either<Failure, String>> getSessionId() async =>
      const Left(ServerFailure(message: 'Session error'));

  @override
  Future<Either<Failure, UserModel>> getAccountDetails({
    required String sessionId,
  }) async => const Left(ServerFailure(message: 'Account error'));

  @override
  Future<Either<Failure, UserModel>> logIn({
    required String email,
    required String password,
  }) async => const Left(ServerFailure(message: 'Invalid credentials'));

  @override
  Future<Either<Failure, UserModel>> getUserData({
    required String userId,
  }) async => const Left(ServerFailure(message: 'No user found'));

  @override
  Future saveUserData({required UserModel user}) async {}

  @override
  Future<Either<Failure, Unit>> logout({required String uId}) async =>
      const Left(ServerFailure(message: 'Logout failed'));

  @override
  Future<bool> isAuthenticated() async => false;
}
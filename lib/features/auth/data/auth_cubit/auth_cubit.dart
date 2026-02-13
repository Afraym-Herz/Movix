import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_state.dart';
import 'package:movix/features/auth/data/models/user_model.dart';
import 'package:movix/features/auth/data/repo/auth_repo.dart';
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> signin({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (l) => emit(AuthFailure(l.toString())),
      (r) => emit(SigninSuccess(r)),
    );
  }

 

  Future<void> forgetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    final result = await authRepo.forgetPassword(email: email);
    result.fold(
      (l) => emit(AuthFailure(l.toString())),
      (r) => emit(ForgetPasswordSuccess(r)),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String refreshToken,
  }) async {
    emit(ResetPasswordLoading());
    final result = await authRepo.resetPassword(
      email: email,
      newPassword: newPassword,
      refreshToken: refreshToken,
    );
    result.fold(
      (l) => emit(AuthFailure(l.toString())),
      (r) => emit(ResetPasswordSuccess(r)),
    );
  }

  Future<void> logout({required String uId}) async {
    emit(AuthLoading());
    final result = await authRepo.logout(uId: uId);
    result.fold(
      (l) => emit(AuthFailure(l.toString())),
      (r) => emit(LogoutSuccess()),
    );
  }

  Future<void> refreshToken() async {
    emit(RefreshTokenLoading());
    final result = await authRepo.refreshToken();
    result.fold(
      (l) => emit(AuthFailure(l.toString())),
      (r) => emit(RefreshTokenSuccess(r)),
    );
  }

  Future<void> getUserData({required String userId}) async {
    emit(GetUserLoading());
    final result = await authRepo.getUserData(userId: userId);

    result.fold(
      (l) => emit(AuthFailure(l.toString())),
      (r) => emit(GetUserSuccess(r)),
    );
  }

  Future<void> saveUserData({required UserModel user}) async {
    emit(SavedUserDataLoading());
    try {
      await authRepo.saveUserData(user: user);
      emit(SavedUserData(user));
    } catch (e) {
      emit(SavedUserDataFailure(e.toString()));
    }
  }

  Future checkAuthenticationStatus() async {
    emit(AuthLoading());
    final isAuthenticated = await authRepo.isAuthenticated();
    log('isAuthenticated: $isAuthenticated');
    if (isAuthenticated) {
      emit(UnAuthenticated());
    } else {
      final userResult = await authRepo.getUserData(
        userId: await SecureStorage().getUserId() ?? 'userId not found',
      );
      userResult.fold(
        (l) => emit(UnAuthenticated()),
        (r) => emit(Authenticated(r)),);
    }
  }  
}


import 'package:movix/features/auth/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {} // for signin + signup

class Authenticated extends AuthState {
  final UserModel user;
  Authenticated(this.user);
}

class UnAuthenticated extends AuthState {}

class LogoutLoading extends AuthState {}

class RefreshTokenLoading extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ForgetPasswordLoading extends AuthState {}

class GetUserLoading extends AuthState {}

class GetUserSuccess extends AuthState {
  final UserModel user;
  GetUserSuccess(this.user);
}

class GetUserFailure extends AuthState {
  final String errorMessage;
  GetUserFailure(this.errorMessage);
}

class SavedUserData extends AuthState {
  final UserModel user;
  SavedUserData(this.user);
}

class SavedUserDataLoading extends AuthState {}
class SavedUserDataFailure extends AuthState {
  final String errorMessage;
  SavedUserDataFailure(this.errorMessage);
}

class SigninSuccess extends AuthState {
  final UserModel user;
  SigninSuccess(this.user);
}


class LogoutSuccess extends AuthState {}

class RefreshTokenSuccess extends AuthState {
  final String accessToken;
  RefreshTokenSuccess(this.accessToken);
}

class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess(this.message);
}

class ForgetPasswordSuccess extends AuthState {
  final String message;
  ForgetPasswordSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(this.errorMessage);
}

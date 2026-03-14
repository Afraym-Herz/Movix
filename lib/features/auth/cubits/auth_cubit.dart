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
    final result = await authRepo.logIn(
      email: email,
      password: password,
    );
    result.fold(
      (l) => emit(AuthFailure(l.toString())),
      (r) => emit(AuthSuccess(r)),
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

  Future<void> checkAuthenticationStatus() async {
    emit(AuthLoading());
   
      final userResult = await authRepo.getUserData(
        userId: await const SecureStorage().getUserId() ?? 'userId not found',
      );
      userResult.fold(
        (l) => emit(UnAuthenticated()),
        (r) => emit(Authenticated(r)),);
  }  

   UserModel? get currentUser => switch (state) {
    AuthSuccess(user: final u) => u,
    Authenticated(user: final u) => u,
    _ => null,
  };

}

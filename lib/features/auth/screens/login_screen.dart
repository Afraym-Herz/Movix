import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/widgets/background_image_stack.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:movix/features/auth/data/repo/auth_repo.dart';
import 'package:movix/features/auth/screens/widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BackgroundImageStack(
        child: BlocProvider(
          create: (context) => AuthCubit(
            getIt.get<AuthRepo>(),
          ),
          child: const LoginScreenBody(),
        ),
      ),
    );
  }
}

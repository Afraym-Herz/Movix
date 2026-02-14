import 'package:flutter/material.dart';
import 'package:movix/core/widgets/background_image_stack.dart';
import 'package:movix/features/auth/screens/widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundImageStack(
        child: LoginScreenBody(),
      ),
    );
  }
}


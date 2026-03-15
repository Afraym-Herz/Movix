import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/assets.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_state.dart';
import 'package:movix/features/auth/ui/screens/login_screen.dart';
import 'package:movix/features/main_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/splash-screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fade;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    scale = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.read<AuthCubit>().checkAuthenticationStatus();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose(); // ✅ dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>( // ✅ BlocListener not BlocConsumer
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainLayout.routeName,
              (route) => false,
            );
          } else if (state is UnAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false,
            );
          }
        },
        child: FadeTransition(
          opacity: fade,
          child: ScaleTransition(
            scale: scale,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesSplashImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
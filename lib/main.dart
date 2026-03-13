import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/on_generate_route.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:movix/features/auth/data/repo/auth_repo.dart';
import 'package:movix/features/auth/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        getIt.get<AuthRepo>(),
      ),
      child: MaterialApp(
        title: 'Movix',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashScreen.routeName,
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaler
              .scale(1)
              .clamp(1, 1.2)
              .toDouble();
          return MediaQuery(
            data: mediaQueryData.copyWith(textScaler: TextScaler.linear(scale)),
            child: child!,
          );
        },
      ),
    );
  }
}

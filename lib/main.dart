import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/assets.dart';
import 'package:movix/core/utils/on_generate_route.dart';
import 'package:movix/features/auth/screens/login_screen.dart';
import 'package:movix/features/auth/screens/splash_screen.dart';
import 'package:movix/features/show_movies/screens/AItop_rated_movies_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

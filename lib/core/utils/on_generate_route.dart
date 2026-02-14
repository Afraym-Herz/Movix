import 'package:flutter/material.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/features/auth/screens/login_screen.dart';
import 'package:movix/features/auth/screens/splash_screen.dart';
import 'package:movix/features/home/screens/top_rated_movies_screen.dart';

Route <dynamic> onGenerateRoute(RouteSettings settings) {

  switch (settings.name) {

    case SplashScreen.routeName:
      return  buildCinematicRoute(const SplashScreen());
    case LoginScreen.routeName:
      return buildCinematicRoute(const LoginScreen());  
    case TopRatedMoviesScreen.routeName:
      return buildCinematicRoute(const TopRatedMoviesScreen());  

    default:
      return buildCinematicRoute(const LoginScreen());
  }

}
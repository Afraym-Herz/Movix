import 'package:flutter/material.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/features/auth/screens/login_screen.dart';
import 'package:movix/features/auth/screens/splash_screen.dart';
import 'package:movix/features/home/screens/movie_box_home_screen.dart';
import 'package:movix/features/main_layout.dart';
import 'package:movix/features/movie_details/screens/AImovie_details_screen.dart';

Route <dynamic> onGenerateRoute(RouteSettings settings) {

  switch (settings.name) {

    case SplashScreen.routeName:
      return  buildCinematicRoute(const SplashScreen());
    case LoginScreen.routeName:
      return buildCinematicRoute(const LoginScreen());  
    case  MovieBoxHomeScreen.routeName:
      return buildCinematicRoute(const  MovieBoxHomeScreen());  
    case MainLayout.routeName:
      return buildCinematicRoute(const MainLayout());  
    case AimovieDetailsScreen.routeName:
      return buildCinematicRoute(AimovieDetailsScreen());  

    default:
      return buildCinematicRoute(const LoginScreen());
  }

}
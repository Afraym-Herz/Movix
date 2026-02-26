import 'package:flutter/material.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/features/auth/screens/login_screen.dart';
import 'package:movix/features/auth/screens/splash_screen.dart';
import 'package:movix/features/movies_home/screens/movie_box_home_screen.dart';
import 'package:movix/features/movies_home/screens/now_playing_movies_screen.dart';
import 'package:movix/features/movies_home/screens/popular_movies_screen.dart';
import 'package:movix/features/movies_home/screens/top_rated_movies_screen.dart';
import 'package:movix/features/movies_home/screens/trending_movies_screen.dart';
import 'package:movix/features/main_layout.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/movie_details/screens/recommended_movies_screen.dart';
import 'package:movix/features/movies_home/screens/up_coming_movies_screen.dart';
import 'package:movix/features/search/screens/search_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return buildCinematicRoute(const SplashScreen());
    case LoginScreen.routeName:
      return buildCinematicRoute(const LoginScreen());
    case MovieBoxHomeScreen.routeName:
      return buildCinematicRoute(const MovieBoxHomeScreen());
    case MainLayout.routeName:
      return buildCinematicRoute(const MainLayout());
    case TrendingMoviesScreen.routeName:
      return buildCinematicRoute(const TrendingMoviesScreen());
    case PopularMoviesScreen.routeName:
      return buildCinematicRoute(const PopularMoviesScreen());
    case TopRatedMoviesScreen.routeName:
      return buildCinematicRoute(const TopRatedMoviesScreen());
    case MovieDetailsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const MovieDetailsScreen(),
        settings: settings,
      );
    case SearchScreen.routeName:
      return buildCinematicRoute(const SearchScreen());  
    case RecommendedMoviesScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => RecommendedMoviesScreen(movieId: settings.arguments as int),
        settings: settings,
      );
    case UpComingMoviesScreen.routeName:
      return buildCinematicRoute(const UpComingMoviesScreen());
    case NowPlayingMoviesScreen.routeName:
      return buildCinematicRoute(const NowPlayingMoviesScreen());  

    default:
      return buildCinematicRoute(const LoginScreen());
  }
}

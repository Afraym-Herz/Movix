import 'package:flutter/material.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/features/auth/ui/screens/login_screen.dart';
import 'package:movix/features/auth/ui/screens/splash_screen.dart';
import 'package:movix/features/compare_movies/screens/compare_movies_screen.dart';
import 'package:movix/features/movies_home/screens/movie_box_home_screen.dart';
import 'package:movix/features/movies_home/screens/now_playing_movies_screen.dart';
import 'package:movix/features/movies_home/screens/popular_movies_screen.dart';
import 'package:movix/features/movies_home/screens/top_rated_movies_screen.dart';
import 'package:movix/features/movies_home/screens/trending_movies_screen.dart';
import 'package:movix/features/main_layout.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/movie_details/screens/recommended_movies_screen.dart';
import 'package:movix/features/movies_home/screens/up_coming_movies_screen.dart';
import 'package:movix/features/tv_series_details/screens/recommended_tv_series_screen.dart';
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return buildCinematicRoute(const SplashScreen());
    case LoginScreen.routeName:
      return buildCinematicRoute(const LoginScreen());
    case MovieBoxHomeScreen.routeName:
      return buildCinematicRoute(const MovieBoxHomeScreen());
    case MainLayout.routeName:
      return MaterialPageRoute(
        builder: (context) => const MainLayout(),
        settings: settings,
      );
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

    case RecommendedMoviesScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>
            RecommendedMoviesScreen(movieId: settings.arguments as int),
        settings: settings,
      );
    case UpComingMoviesScreen.routeName:
      return buildCinematicRoute(const UpComingMoviesScreen());
    case NowPlayingMoviesScreen.routeName:
      return buildCinematicRoute(const NowPlayingMoviesScreen());
    case RecommendedTVSeriesScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>
            RecommendedTVSeriesScreen(tvSeriesId: settings.arguments as int),
        settings: settings,
      );
    case TVSeriesDetailsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const TVSeriesDetailsScreen(),
        settings: settings,
      );
    case CompareMoviesScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CompareMoviesScreen(),
        settings: settings,
      );

    default:
      return buildCinematicRoute(const LoginScreen());
  }
}


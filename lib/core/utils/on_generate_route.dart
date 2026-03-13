import 'package:flutter/material.dart';
import 'package:movix/features/auth/screens/login_screen.dart';
import 'package:movix/features/auth/screens/splash_screen.dart';
import 'package:movix/features/explore/screens/explore_screen.dart';
import 'package:movix/features/main_layout.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/movies_home/screens/movies_home_screen.dart';
import 'package:movix/features/saved_movies/screens/saved_movies_screen.dart';
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';
import 'package:movix/features/tv_series_home/screens/tv_series_box_home_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: settings,
      );
    case MainLayout.routeName:
      return MaterialPageRoute(
        builder: (_) => const MainLayout(),
        settings: settings,
      );
    case MovieBoxHomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const MovieBoxHomeScreen(),
        settings: settings,
      );
    case TVSeriesBoxHomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const TVSeriesBoxHomeScreen(),
        settings: settings,
      );
    case MovieDetailsScreen.routeName:
      final movieId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movieId: movieId),
      );
    case TvSeriesDetailsScreen.routeName:
      final tvSeriesId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (context) => TvSeriesDetailsScreen(tvSeriesId: tvSeriesId),
      );
    case ExploreScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const ExploreScreen(),
        settings: settings,
      );
    case SavedMovieScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SavedMovieScreen(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/widgets/custom_divider.dart';
import 'package:movix/features/movies_home/cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/trendind_movies_cubit/trending_movies_cubit.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/movies_home/cubits/up_coming_movies_cubit/up_coming_movies_cubit.dart';
import 'package:movix/features/movies_home/screens/widgets/now_playing_movies_section.dart';
import 'package:movix/features/movies_home/screens/widgets/popular_movies_section.dart';
import 'package:movix/features/movies_home/screens/widgets/top_rated_movie_section.dart';
import 'package:movix/features/movies_home/screens/widgets/trending_movies_section.dart';
import 'package:movix/features/tv_series_home/screens/widgets/up_coming_movies_section.dart';

class MovieBoxHomeScreen extends StatelessWidget {
  const MovieBoxHomeScreen({super.key});

  static const routeName = '/movie-box-home-screen';

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  TrendingMoviesCubit(getIt.get<MovieRepository>())
                    ..fetchTrendingMovies(),
              child: const TrendingSection(),
            ),
          ),
          const SliverToBoxAdapter(child: CustomDivider()),
          
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  PopularMoviesCubit(getIt.get<MovieRepository>())
                    ..fetchPopularMovies(),
              child: const PopularSection(),
            ),
          ),
          
          const SliverToBoxAdapter(child: CustomDivider()),
          
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  TopRatedMoviesCubit(getIt.get<MovieRepository>())
                    ..fetchTopRatedMovies(),
              child: const TopRatedSection(),
            ),
          ),
          
          const SliverToBoxAdapter(child: CustomDivider()),
          
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  NowPlayingMoviesCubit(getIt.get<MovieRepository>())
                    ..fetchNowPlayingMovies(),
              child: const NowPlayingSection(),
            ),
          ),
          
          const SliverToBoxAdapter(child: CustomDivider()),
          
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  UpComingMoviesCubit(getIt.get<MovieRepository>())
                    ..fetchUpComingMovies(),
              child: const UpComingSection(),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

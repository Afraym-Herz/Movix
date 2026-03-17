import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/widgets/custom_divider.dart';
import 'package:movix/features/movies_home/cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/trendind_movies_cubit/trending_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/up_coming_movies_cubit/up_coming_movies_cubit.dart';
import 'package:movix/features/movies_home/screens/widgets/now_playing_movies_section.dart';
import 'package:movix/features/movies_home/screens/widgets/popular_movies_section.dart';
import 'package:movix/features/movies_home/screens/widgets/top_rated_movie_section.dart';
import 'package:movix/features/movies_home/screens/widgets/trending_movies_section.dart';
import 'package:movix/features/movies_home/screens/widgets/up_coming_movies_section.dart';

class MovieBoxHomeScreen extends StatelessWidget {
  const MovieBoxHomeScreen({super.key});

  static const routeName = '/movie-box-home-screen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TrendingMoviesCubit(getIt.get<MovieRepository>())
                ..fetchTrendingMovies(),
        ),
        BlocProvider(
          create: (context) => PopularMoviesCubit(getIt.get<MovieRepository>())
            ..fetchPopularMovies(),
        ),
        BlocProvider(
          create: (context) => TopRatedMoviesCubit(getIt.get<MovieRepository>())
            ..fetchTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) =>
              NowPlayingMoviesCubit(getIt.get<MovieRepository>())
                ..fetchNowPlayingMovies(),
        ),
        BlocProvider(
          create: (context) =>
              UpComingMoviesCubit(getIt.get<MovieRepository>())
                ..fetchUpComingMovies(),
        ),
      ],
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TrendingSection(),
          ),
          SliverToBoxAdapter(child: CustomDivider()),
          SliverToBoxAdapter(
            child: PopularSection(),
          ),
          SliverToBoxAdapter(child: CustomDivider()),
          SliverToBoxAdapter(
            child: TopRatedSection(),
          ),
          SliverToBoxAdapter(child: CustomDivider()),
          SliverToBoxAdapter(
            child: NowPlayingSection(),
          ),
          SliverToBoxAdapter(child: CustomDivider()),
          SliverToBoxAdapter(
            child: UpComingSection(),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}



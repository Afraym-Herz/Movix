import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/widgets/custom_divider.dart';
import 'package:movix/features/home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/home/cubits/trendind_movies_cubit/trending_movies_cubit.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/home/screens/widgets/header_home_screen.dart';
import 'package:movix/features/home/screens/widgets/popular_section.dart';
import 'package:movix/features/home/screens/widgets/top_rated_section.dart';
import 'package:movix/features/home/screens/widgets/trending_section.dart';

class MovieBoxHomeScreen extends StatefulWidget {
  const MovieBoxHomeScreen({super.key});

  static const routeName = '/movie-box-home-screen';

  @override
  State<MovieBoxHomeScreen> createState() => _MovieBoxHomeScreenState();
}

class _MovieBoxHomeScreenState extends State<MovieBoxHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HeaderHomeScreen()),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  TrendingMoviesCubit(getIt.get<MovieRepository>()),
              child: const TrendingSection(),
            ),
          ),
          const SliverToBoxAdapter(child: CustomDivider()),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  PopularMoviesCubit(getIt.get<MovieRepository>()),
              child: const PopularSection(),
            ),
          ),
          const SliverToBoxAdapter(child: CustomDivider()),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => TopRatedMoviesCubit(getIt.get<MovieRepository>()),
              child: const TopRatedSection(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

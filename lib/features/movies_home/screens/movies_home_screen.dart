import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/widgets/custom_divider.dart';
import 'package:movix/core/widgets/header_home_screen.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_states.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_states.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';

class MovieBoxHomeScreen extends StatelessWidget {
  const MovieBoxHomeScreen({super.key});

  static const routeName = '/movies-home-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HeaderHomeScreen(title: 'Movies')),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  TopRatedMoviesCubit(getIt.get<MovieRepository>())
                    ..fetchTopRatedMovies(),
              child: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesStates>(
                builder: (context, state) {
                  return SectionWrapper(
                    title: 'Top Rated',
                    child: SizedBox(
                      height: 240,
                      child: ListViewShowsScreens(
                        cardWidth: 130,
                        shows: state.topRatedMovies,
                        isMovies: true,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: CustomDivider()),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  PopularMoviesCubit(getIt.get<MovieRepository>())
                    ..fetchPopularMovies(),
              child: BlocBuilder<PopularMoviesCubit, PopularMoviesStates>(
                builder: (context, state) {
                  return SectionWrapper(
                    title: 'Popular',
                    child: SizedBox(
                      height: 240,
                      child: ListViewShowsScreens(
                        cardWidth: 130,
                        shows: state.popularMovies,
                        isMovies: true,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

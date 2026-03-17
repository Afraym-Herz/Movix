import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_states.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopRatedMoviesScreen extends StatelessWidget {
  const TopRatedMoviesScreen({super.key});

  static const String routeName = '/top-rated-movies';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesStates>(
        builder: (context, state) {
          if (state.topRatedIsLoading && state.topRatedMovies.isEmpty) {
            return Skeletonizer(
              enabled: true,
              child: SliverGridViewBuilder(
                screenWidth: screenWidth,
                shows: fakeMovies,
                isLoading: true,
                isMovies: true,
              ),
            );
          }

          if (state.errorMessage != null && state.topRatedMovies.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return PagginationWrapper(
            onLoadMore: () => context
                .read<TopRatedMoviesCubit>()
                .fetchTopRatedMovies(),
            child: RefreshIndicator(
              onRefresh: () async =>
                  context.read<TopRatedMoviesCubit>().fetchTopRatedMovies(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  buildSliverAppBar(context, title: "Top Rated Movies"),
                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.topRatedMovies,
                    isLoading: state.topRatedIsLoading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

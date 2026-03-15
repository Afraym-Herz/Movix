import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/trendind_movies_cubit/trending_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/trendind_movies_cubit/trending_movies_states.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';

class TrendingMoviesScreen extends StatelessWidget {
  const TrendingMoviesScreen({super.key});

  static const String routeName = '/trending-movies';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<TrendingMoviesCubit, TrendingMoviesStates>(
        builder: (context, state) {
          if (state.trendingIsLoading && state.trendingMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.trendingMovies.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return PagginationWrapper(
            onLoadMore: () => context
                .read<TrendingMoviesCubit>()
                .fetchTrendingMovies(),
            child: RefreshIndicator(
              onRefresh: () async =>
                  context.read<TrendingMoviesCubit>().fetchTrendingMovies(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  buildSliverAppBar(context, title: "Trending Movies"),
                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.trendingMovies,
                    isLoading: state.trendingIsLoading,
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

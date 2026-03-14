import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_states.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';

class PopularMoviesScreen extends StatelessWidget {
  const PopularMoviesScreen({super.key});

  static const String routeName = '/popular-movies';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<PopularMoviesCubit, PopularMoviesStates>(
        builder: (context, state) {
          if (state.popularIsLoading && state.popularMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.popularMovies.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<PopularMoviesCubit>().fetchPopularMovies(),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                buildSliverAppBar(context, title: "Popular Movies"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                PagginationWrapper(
                  onLoadMore: () => context
                      .read<PopularMoviesCubit>()
                      .fetchPopularMovies(),
                  child: SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.popularMovies,
                    isLoading: state.popularIsLoading,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/up_coming_movies_cubit/up_coming_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/up_coming_movies_cubit/up_coming_movies_states.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';

class UpComingMoviesScreen extends StatelessWidget {
  const UpComingMoviesScreen({super.key});

  static const String routeName = '/up-coming-movies';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<UpComingMoviesCubit, UpComingMoviesStates>(
        builder: (context, state) {
          if (state.upComingIsLoading && state.upComingMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.upComingMovies.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<UpComingMoviesCubit>().fetchUpComingMovies(),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                buildSliverAppBar(context, title: "Upcoming Movies"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                PagginationWrapper(
                  onLoadMore: () => context
                      .read<UpComingMoviesCubit>()
                      .fetchUpComingMovies(),
                  child: SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.upComingMovies,
                    isLoading: state.upComingIsLoading,
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

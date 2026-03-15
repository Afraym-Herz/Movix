import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/now_playing_movies_cubit/now_playing_movies_states.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';

class NowPlayingMoviesScreen extends StatelessWidget {
  const NowPlayingMoviesScreen({super.key});

  static const String routeName = '/now-playing-movies';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesStates>(
        builder: (context, state) {
          if (state.nowPlayingIsLoading && state.nowPlayingMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.nowPlayingMovies.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return PagginationWrapper(
            onLoadMore: () => context
                .read<NowPlayingMoviesCubit>()
                .fetchNowPlayingMovies(),
            child: RefreshIndicator(
              onRefresh: () async =>
                  context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  buildSliverAppBar(context, title: "Now Playing Movies"),
                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.nowPlayingMovies,
                    isLoading: state.nowPlayingIsLoading,
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

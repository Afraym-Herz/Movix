import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:movix/features/tv_series_home/cubits/top_rated_tv_series_cubit/top_rated_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/top_rated_tv_series_cubit/top_rated_tv_series_states.dart';

class TopRatedTVSeriesScreen extends StatelessWidget {
  const TopRatedTVSeriesScreen({super.key});

  static const String routeName = '/top-rated-tv-series-screen';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<TopRatedTVSeriesCubit, TopRatedTVSeriesStates>(
        builder: (context, state) {
          if (state.topRatedIsLoading && state.topRatedTVSeries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.topRatedTVSeries.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<TopRatedTVSeriesCubit>().fetchTopRatedTVSeries(),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),

              slivers: [
                buildSliverAppBar(context, title: "Top Rated TVSeries"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                PagginationWrapper(
                  onLoadMore: () => context
                      .read<TopRatedTVSeriesCubit>()
                      .fetchTopRatedTVSeries(),
                  child: SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.topRatedTVSeries,
                    isLoading: state.topRatedIsLoading,
                    isMovies: false ,
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

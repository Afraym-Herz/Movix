import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:movix/features/tv_series_home/cubits/latest_tv_series_cubit/latest_tv_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/latest_tv_series_cubit/latest_tv_states.dart';

class LatestTVSeriesScreen extends StatelessWidget {
  const LatestTVSeriesScreen({super.key});

  static const String routeName = '/up-coming-movies';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,

      body: BlocBuilder<LatestTVSeriesCubit, LatestTVSeriesStates>(
        builder: (context, state) {
          if (state.latestTVSeriesIsLoading && state.latestTVSeries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.latestTVSeries.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => context
                .read<LatestTVSeriesCubit>()
                .getLatestTVSeries(refresh: true),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),

              slivers: [
                buildSliverAppBar(context, title: "Upcoming Movies"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                PagginationWrapper(
                  onLoadMore: () => context
                      .read<LatestTVSeriesCubit>()
                      .getLatestTVSeries(),
                  child: SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.latestTVSeries,
                    isLoading: state.latestTVSeriesIsLoading,
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

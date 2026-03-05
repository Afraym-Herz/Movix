import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:movix/features/tv_series_home/cubits/popular_tv_series_cubit/popular_tv_series_cubit.dart';

import '../cubits/popular_tv_series_cubit/popular_tv_series_states.dart';

class PopularTVSeriesScreen extends StatelessWidget {
  const PopularTVSeriesScreen({super.key});

  static const String routeName = '/popular-tv-series-screen';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,

      body: BlocBuilder<PopularTVSeriesCubit, PopularTVSeriesStates>(
        builder: (context, state) {
          if (state.popularIsLoading && state.popularTVSeries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.popularTVSeries.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                context.read<PopularTVSeriesCubit>().fetchPopularTVSeries(),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),

              slivers: [
                buildSliverAppBar(context, title: "Popular TVSeries"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                PagginationWrapper(
                  onLoadMore: () =>
                      context.read<PopularTVSeriesCubit>().fetchPopularTVSeries(),
                  child: SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.popularTVSeries,
                    isLoading: state.popularIsLoading,
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

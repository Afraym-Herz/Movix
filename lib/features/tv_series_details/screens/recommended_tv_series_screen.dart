import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:movix/features/tv_series_details/cubits/recommended_tv_series_cubit/recommended_tv_series_cubit.dart';
import 'package:movix/features/tv_series_details/cubits/recommended_tv_series_cubit/recommended_tv_series_states.dart';

class RecommendedTVSeriesScreen extends StatelessWidget {
  const RecommendedTVSeriesScreen({super.key, required this.tvSeriesId});

  static const String routeName = '/recommended-tv-series-screen';
  final int tvSeriesId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<RecommendedTVSeriesCubit, RecommendedTVSeriesStates>(
        builder: (context, state) {
          if (state.recommendedIsLoading && state.recommendedTVSeries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.recommendedTVSeries.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => context
                .read<RecommendedTVSeriesCubit>()
                .fetchRecommendedTVSeries(
                  tvSeriesId: tvSeriesId,
                  refresh: true,
                ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                buildSliverAppBar(context, title: "Recommended TVSeries"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                SliverGridViewBuilder(
                  screenWidth: screenWidth,
                  shows: state.recommendedTVSeries,
                  isLoading: state.recommendedIsLoading,
                  isMovies: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


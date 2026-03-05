import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:movix/features/tv_series_home/cubits/airing_today_cubit/airing_today_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/airing_today_cubit/airing_today_states.dart';

class AiringTodayTVSeriesScreen extends StatelessWidget {
  const AiringTodayTVSeriesScreen({super.key});

  static const String routeName = '/airing-today-tv-series';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<AiringTVSeriesCubit, AiringTodayTVSeriesStates>(
        builder: (context, state) {
          if (state.airingTodayIsLoading && state.airingTodayTVSeries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.airingTodayTVSeries.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => context
                .read<AiringTVSeriesCubit>() .fetchAiringTodayTVSeries(refresh: true),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),

              slivers: [
                buildSliverAppBar(context, title: "Airing Today TVSeries"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                PagginationWrapper(
                  onLoadMore: () => context
                      .read<AiringTVSeriesCubit>()
                      .fetchAiringTodayTVSeries(),
                  child: SliverGridViewBuilder(
                    screenWidth: screenWidth,
                    shows: state.airingTodayTVSeries,
                    isLoading: state.airingTodayIsLoading,
                    isMovies: false,
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

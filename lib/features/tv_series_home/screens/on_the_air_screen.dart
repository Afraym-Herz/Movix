import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/sliver_app_bar.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:movix/features/tv_series_home/cubits/on_the_air_tv_series_cubit/on_the_air_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/on_the_air_tv_series_cubit/on_the_air_tv_series_states.dart';

class OnTheAirScreen extends StatelessWidget {
  const OnTheAirScreen({super.key});
  static const String routeName = '/onTheAir-tv-series-screen';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,

      body: BlocBuilder<OnTheAirTvSeriesCubit, OnTheAirTvSeriesStates>(
        builder: (context, state) {
          if (state.onTheAirIsLoading && state.onTheAirTVSeries.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.onTheAirTVSeries.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => context
                .read<OnTheAirTvSeriesCubit>()
                .fetchOnTheAirTVSeries(refresh: true),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),

              slivers: [
                buildSliverAppBar(context, title: "onTheAir TVSeries"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                SliverGridViewBuilder(
                  screenWidth: screenWidth,
                  shows: state.onTheAirTVSeries,
                  isLoading: state.onTheAirIsLoading,
                  isMovies:  false ,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

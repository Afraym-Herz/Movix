import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/tv_series_home/cubits/latest_tv_series_cubit/latest_tv_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/latest_tv_series_cubit/latest_tv_states.dart';
import 'package:movix/features/tv_series_home/screens/latest_tv_series_screen.dart';

class LatestTVSeriesSection extends StatelessWidget {
  const LatestTVSeriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final latestTVSeriesCubit = context.read<LatestTVSeriesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: latestTVSeriesCubit,
              child: const LatestTVSeriesScreen(),
            ),
          ),
        );
      },
      title: "Latest Movies",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<LatestTVSeriesCubit, LatestTVSeriesStates>(
          builder: (context, state) {
            if (state.latestTVSeriesIsLoading && state.latestTVSeries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.latestTVSeries.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<LatestTVSeriesCubit>().getLatestTVSeries(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<LatestTVSeriesCubit>().getLatestTVSeries(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.latestTVSeries,
                isTrending: false,
                isMovies: false ,
              ),
            );
          },
        ),
      ),
    );
  }
}

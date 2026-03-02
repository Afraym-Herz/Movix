import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/tv_series_home/cubits/top_rated_tv_series_cubit/top_rated_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/top_rated_tv_series_cubit/top_rated_tv_series_states.dart';
import 'package:movix/features/tv_series_home/screens/top_rated__tv_series_screen.dart';

class TopRatedTVSeriesSection extends StatelessWidget {
  const TopRatedTVSeriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final topRatedCubit = context.read<TopRatedTVSeriesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: topRatedCubit,
              child: const TopRatedTVSeriesScreen(),
            ),
          ),
        );
      },
      title: "Top Rated Movies",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<TopRatedTVSeriesCubit, TopRatedTVSeriesStates>(
          builder: (context, state) {
            if (state.topRatedIsLoading && state.topRatedTVSeries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.topRatedTVSeries.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<TopRatedTVSeriesCubit>().fetchTopRatedTVSeries(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<TopRatedTVSeriesCubit>().fetchTopRatedTVSeries(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.topRatedTVSeries,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/tv_series_home/cubits/popular_tv_series_cubit/popular_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/popular_tv_series_cubit/popular_tv_series_states.dart';
import 'package:movix/features/tv_series_home/screens/popular_tv_series_screen.dart';

class PopularTVSeriesSection extends StatelessWidget {
  const PopularTVSeriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final popularTVSeriesCubit = context.read<PopularTVSeriesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: popularTVSeriesCubit,
              child: const PopularTVSeriesScreen(),
            ),
          ),
        );
      },
      title: "Popular TVSeries",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<PopularTVSeriesCubit, PopularTVSeriesStates>(
          builder: (context, state) {
            if (state.popularIsLoading && state.popularTVSeries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.popularTVSeries.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<PopularTVSeriesCubit>().fetchPopularTVSeries(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<PopularTVSeriesCubit>().fetchPopularTVSeries(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.popularTVSeries,
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

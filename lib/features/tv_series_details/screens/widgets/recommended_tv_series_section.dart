import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/tv_series_details/cubits/recommended_tv_series_cubit/recommended_tv_series_cubit.dart';
import 'package:movix/features/tv_series_details/cubits/recommended_tv_series_cubit/recommended_tv_series_states.dart';
import 'package:movix/features/tv_series_details/screens/recommended_tv_series_screen.dart';

class RecommendedTVSeriesSection extends StatelessWidget {
  const RecommendedTVSeriesSection({super.key, required this.tvSeriesId});

  final int tvSeriesId;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final recommendedTVSeriesCubit = context.read<RecommendedTVSeriesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: recommendedTVSeriesCubit,
              child: RecommendedTVSeriesScreen(tvSeriesId: tvSeriesId),
            ),
          ),
        );
      },
      title: "Recommended TVSeries",
      child: SizedBox(
        height: cardHeight + 70,
        child:
            BlocBuilder<RecommendedTVSeriesCubit, RecommendedTVSeriesStates>(
              builder: (context, state) {
                if (state.recommendedIsLoading &&
                    state.recommendedTVSeries.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage != null &&
                    state.recommendedTVSeries.isEmpty) {
                  return Center(
                    child: CustomErrorMessageLoading(
                      errorMessage: state.errorMessage!,
                      onRefresh: () {
                        context
                            .read<RecommendedTVSeriesCubit>()
                            .fetchRecommendedTVSeries(refresh: true, tvSeriesId: tvSeriesId);
                      },
                    ),
                  );
                }
                return state.recommendedTVSeries.isEmpty
                    ? Center(
                        child: Text(
                          'No recommendations available.',
                          style: AppTextStyles.bold16(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      )
                    : PagginationWrapper(
                      onLoadMore: () { 
                        context
                            .read<RecommendedTVSeriesCubit>()
                            .fetchRecommendedTVSeries(tvSeriesId: tvSeriesId);
                       },
                      child: ListViewShowsScreens(
                          cardWidth: cardWidth,
                          shows: state.recommendedTVSeries,
                          isTrending: false,
                          isRecommended: true,
                          isMovies: false,
                        ),
                    );
              },
            ),
      ),
    );
  }
}


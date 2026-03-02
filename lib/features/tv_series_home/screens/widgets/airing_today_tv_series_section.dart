import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/tv_series_home/cubits/airing_today_cubit/airing_today_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/airing_today_cubit/airing_today_states.dart';
import 'package:movix/features/tv_series_home/screens/airing_today_tv_series_screen.dart';

class AiringTodayTvSeriesSection extends StatelessWidget {
  const AiringTodayTvSeriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final airingTodayCubit = context.read<AiringTVSeriesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: airingTodayCubit,
              child: const AiringTodayTVSeriesScreen(),
            ),
          ),
        );
      },
      title: "Airing Today TVSeries",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<AiringTVSeriesCubit, AiringTodayTVSeriesStates>(
          builder: (context, state) {
            if (state.airingTodayIsLoading && state.airingTodayTVSeries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.airingTodayTVSeries.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<AiringTVSeriesCubit>() .fetchAiringTodayTVSeries( refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<AiringTVSeriesCubit>().fetchAiringTodayTVSeries(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.airingTodayTVSeries,
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

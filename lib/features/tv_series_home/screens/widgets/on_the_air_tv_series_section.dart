import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/tv_series_home/cubits/on_the_air_tv_series_cubit/on_the_air_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/on_the_air_tv_series_cubit/on_the_air_tv_series_states.dart';
import 'package:movix/features/tv_series_home/screens/on_the_air_screen.dart';

class OnTheAirTvSeriesSection extends StatelessWidget {
  const OnTheAirTvSeriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.44;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final onTheAirMoviesCubit = context.read<OnTheAirTvSeriesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: onTheAirMoviesCubit,
              child: const OnTheAirScreen(),
            ),
          ),
        );
      },
      title: "On The Air TVSeries",
      child: SizedBox(
        height: cardHeight + 70,
        child: BlocBuilder<OnTheAirTvSeriesCubit, OnTheAirTvSeriesStates>(
          builder: (context, state) {
            if (state.onTheAirIsLoading && state.onTheAirTVSeries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.onTheAirTVSeries.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<OnTheAirTvSeriesCubit>().fetchOnTheAirTVSeries(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.onTheAirTVSeries,
                isMovies: false ,
              ),
              onLoadMore: () =>
                  context.read<OnTheAirTvSeriesCubit>().fetchOnTheAirTVSeries(),
            );
          },
        ),
      ),
    );
  }
}

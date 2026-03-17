import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/trendind_movies_cubit/trending_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/trendind_movies_cubit/trending_movies_states.dart';
import 'package:movix/features/movies_home/screens/trending_movies_screen.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.44;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: (){
        final trendingMoviesCubit = context.read<TrendingMoviesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: trendingMoviesCubit,
              child: const TrendingMoviesScreen(),
            ),
          ),
        );
      },
      title: "Trending Movies",
      child: SizedBox(
        height: cardHeight + 70,
        child: BlocBuilder<TrendingMoviesCubit, TrendingMoviesStates>(
          builder: (context, state) {
            if (state.errorMessage != null && state.trendingMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<TrendingMoviesCubit>().fetchTrendingMovies(
                      refresh: true,
                    );
                  },
                ),
              );
            }
            if (state.trendingIsLoading && state.trendingMovies.isEmpty) {
              return Skeletonizer(
                enabled: true,
                child: ListViewShowsScreens(
                  cardWidth: cardWidth,
                  shows: fakeMovies,
                  isLoading: true,
                  isMovies: true,
                  isTrending: true,
                ),
              );
            }

            return PagginationWrapper(
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.trendingMovies,
                isTrending: true,
                isLoading: state.trendingIsLoading && state.trendingMovies.isEmpty,
              ),
              onLoadMore: () =>
                  context.read<TrendingMoviesCubit>().fetchTrendingMovies(),
            );
          },
        ),
      ),
    );
  }
}

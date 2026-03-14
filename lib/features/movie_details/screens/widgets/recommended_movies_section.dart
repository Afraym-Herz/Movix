import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_cubit.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_state.dart';
import 'package:movix/features/movie_details/screens/recommended_movies_screen.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key, required this.movieId});

  final int movieId;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final recommendationMoviesCubit = context.read<RecommendationMoviesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: recommendationMoviesCubit,
              child: RecommendedMoviesScreen(movieId: movieId),
            ),
          ),
        );
      },
      title: "Recommended Movies",
      child: SizedBox(
        height: cardHeight + 70,
        child:
            BlocBuilder<RecommendationMoviesCubit, RecommendationMoviesState>(
              builder: (context, state) {
                if (state.recommendedIsLoading &&
                    state.recommendedMovies.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage != null &&
                    state.recommendedMovies.isEmpty) {
                  return Center(
                    child: CustomErrorMessageLoading(
                      errorMessage: state.errorMessage!,
                      onRefresh: () {
                        context
                            .read<RecommendationMoviesCubit>()
                            .fetchRecommendedMovies(refresh: true, movieId: movieId);
                      },
                    ),
                  );
                }
                return state.recommendedMovies.isEmpty
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
                            .read<RecommendationMoviesCubit>()
                            .fetchRecommendedMovies(movieId: movieId);
                       },
                      child: ListViewShowsScreens(
                          cardWidth: cardWidth,
                          shows: state.recommendedMovies,
                          isTrending: false,
                          isRecommended: true,
                        ),
                    );
              },
            ),
      ),
    );
  }
}

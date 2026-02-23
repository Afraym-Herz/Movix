import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/home/screens/top_rated_screen.dart';
import 'package:movix/features/home/screens/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_movies_screen.dart';
import 'package:movix/features/home/screens/widgets/section_wrapper.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_cubit.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_state.dart';
import 'package:movix/features/movie_details/screens/recommended_movies_screen.dart';

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({super.key, required this.movieId});

  final int movieId;
  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<RecommendationMoviesCubit>().fetchRecommendedMovies(
      movieId: widget.movieId,
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<RecommendationMoviesCubit>().fetchRecommendedMovies(
        movieId: widget.movieId,
      );
    }
  }

  void _refreshMovies() {
    context.read<RecommendationMoviesCubit>().fetchRecommendedMovies(
      refresh: true,
      movieId: widget.movieId,
    );
  }

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
              child: RecommendedMoviesScreen(movieId: widget.movieId),
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
                      onRefresh: _refreshMovies,
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
                    : ListViewMoviesScreens(
                        scrollController: _scrollController,
                        cardWidth: cardWidth,
                        movies: state.recommendedMovies,
                        isTrending: false,
                        isRecommended: true,
                      );
              },
            ),
      ),
    );
  }
}

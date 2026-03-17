import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/widgets/small_show_card.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';

class SliverGridViewBuilder extends StatelessWidget {
  final double screenWidth;
  final List<dynamic> shows;
  final bool isLoading;
  final bool isMovies;

  const SliverGridViewBuilder({
    super.key,
    required this.screenWidth,
    required this.shows,
    required this.isLoading,
    this.isMovies = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInitialLoading = isLoading && shows.isEmpty;
    final bool isPaginationLoading = isLoading && shows.isNotEmpty;

    return Skeletonizer.sliver(
      enabled: isInitialLoading,
      child: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth > 500 ? 4 : 2,
          crossAxisSpacing: 8,
          childAspectRatio: 0.55,
        ),
        itemCount: isInitialLoading ? 8 : (isPaginationLoading ? shows.length + 1 : shows.length),
        itemBuilder: (context, index) {
          if (isInitialLoading) {
            return SmallShowCard(
              show: _getMockShow(),
              onTap: () {},
            );
          }

          if (index >= shows.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final show = shows[index];
          return SmallShowCard(
            show: show,
            onTap: () {
              Navigator.pushNamed(
                context,
                isMovies
                    ? MovieDetailsScreen.routeName
                    : TVSeriesDetailsScreen.routeName,
                arguments: show.id,
              );
            },
          );
        },
      ),
    );
  }

  dynamic _getMockShow() {
    return const MovieModel(
      id: 0,
      title: 'Loading Title Name',
      overview: 'Loading overview text for the movie description goes here.',
      posterPath: '',
      backdropPath: '',
      voteAverage: 0.0,
      releaseDate: '2024-01-01',
      genreIds: [],
      adult: false,
      originalLanguage: 'en',
      popularity: 0.0,
      voteCount: 0,
      originalTitle: 'Loading Original Title',
      video: false,
    );
  }
}

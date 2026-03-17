import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/widgets/small_show_card.dart';
import 'package:movix/core/widgets/trending_card.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';

class ListViewShowsScreens extends StatelessWidget {
  const ListViewShowsScreens({
    super.key,
    required this.cardWidth,
    required this.shows,
    this.isTrending = false,
    this.isRecommended = false,
    this.isMovies = true,
    this.isLoading = false,
  });

  final num cardWidth;
  final List<dynamic> shows;
  final bool isLoading;
  final bool isTrending;
  final bool isRecommended;
  final bool isMovies;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: isLoading ? 5 : shows.length,
        itemBuilder: (context, index) {
          final dynamic show = isLoading ? _getMockShow() : shows[index];
          return isTrending
              ? TrendingCard(
                  width: cardWidth.toDouble(),
                  movie: show as MovieModel,
                  onTap: () {
                    if (isLoading) return;
                    Navigator.pushNamed(
                      context,
                      isMovies
                          ? MovieDetailsScreen.routeName
                          : TVSeriesDetailsScreen.routeName,
                      arguments: show.id,
                    );
                  },
                )
              : SmallShowCard(
                  cardWidth: cardWidth.toDouble(),
                  show: show,
                  onTap: () {
                    if (isLoading) return;
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

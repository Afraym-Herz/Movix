import 'package:flutter/material.dart';
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
  });

  final num cardWidth;
  final List<dynamic> shows;
  bool get isLoading => shows.isEmpty;
  final bool isTrending;
  final bool isRecommended;
  final bool isMovies;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final int itemCount = shows.length >= 12 ? 12 : shows.length;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final dynamic show = shows[index];
        return isTrending
            ? TrendingCard(
                width: cardWidth.toDouble(),
                movie: show as MovieModel,
                onTap: () {
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
    );
  }
}

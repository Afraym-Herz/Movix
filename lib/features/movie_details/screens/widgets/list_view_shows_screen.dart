import 'package:flutter/material.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/utils/assets.dart';
import 'package:movix/core/widgets/small_show_card.dart';
import 'package:movix/core/widgets/trending_card.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

  final _fakeShow = const MovieModel(
    adult: false,
    genreIds: [],
    id: 1,
    originalLanguage: "originalLanguage",
    originalTitle: "originalTitle",
    overview: "overview",
    popularity: 1,
    title: "title",
    posterPath: Assets.imagesSplashImage,
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  @override
  Widget build(BuildContext context) {
    final int itemCount = isLoading
        ? 6
        : (shows.length >= 12 ? 12 : shows.length);
    return Skeletonizer(
      enabled: isLoading,
      effect: const ShimmerEffect(
        baseColor: Color(0xFF2A2A2A),
        highlightColor: Color(0xFF3A3A3A),
        duration: Duration(seconds: 1),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final dynamic show = isLoading ? _fakeShow : shows[index];

          return isTrending
              ? TrendingCard(
                  width: cardWidth.toDouble(),
                  movie: show,
                  onTap: isLoading
                      ? () {}
                      : () {
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
                  onTap: isLoading
                      ? () {}
                      : () {
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
}

import 'package:flutter/material.dart';
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
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth > 500 ? 4 : 2,
        crossAxisSpacing: 8,
        childAspectRatio: 0.55,
      ),
      itemCount: shows.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
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
              isMovies ? MovieDetailsScreen.routeName : TvSeriesDetailsScreen.routeName,
              arguments: show.id,
            );
          },
        );
      },
    );
  }
}

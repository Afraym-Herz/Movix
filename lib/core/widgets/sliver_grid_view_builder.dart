import 'package:flutter/material.dart';
import 'package:movix/core/models/show.dart';
import 'package:movix/core/widgets/small_movie_card.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';

class SliverGridViewBuilder extends StatelessWidget {

  final double screenWidth;
  final List<Show> shows;
  final bool isLoading;

  const SliverGridViewBuilder({super.key, required this.screenWidth, required this.shows, required this.isLoading});

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
        final movie = shows[index];
        return SmallMovieCard(
          movie: movie,
          onTap: () {
            Navigator.pushNamed(
              context,
              MovieDetailsScreen.routeName,
              arguments: movie.id,
            );
          },
        );
      },
    );
  }
}

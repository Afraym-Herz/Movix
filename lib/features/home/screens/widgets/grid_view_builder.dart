import 'package:flutter/material.dart';
import 'package:movix/features/home/models/movie.dart';
import 'package:movix/features/home/screens/widgets/small_movie_card.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';

class GridViewBuilder extends StatelessWidget {
  const GridViewBuilder({
    super.key,
    required this.screenWidth,
    required this.movies,
    required this.isLoading,
  });

  final double screenWidth;
  final List<Movie> movies;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth > 500 ? 4 : 2,
        crossAxisSpacing: 8,
        childAspectRatio: 0.55,
      ),
      itemCount: movies.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= movies.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final movie = movies[index];
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

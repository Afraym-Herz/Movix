import 'package:flutter/material.dart';
import 'package:movix/core/models/show.dart';
import 'package:movix/core/widgets/small_movie_card.dart';
import 'package:movix/core/widgets/trending_card.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';

class ListViewMoviesScreens extends StatelessWidget {
  const ListViewMoviesScreens({
    super.key,
    required this.cardWidth,
    required this.movies,
    this.isTrending = false,
    this.isRecommended = false,
  });

  final num cardWidth;
  final List<Show> movies;
  bool get isLoading => movies.isEmpty;
  final bool isTrending;
  final bool isRecommended ;
  

  @override
  Widget build(BuildContext context) {
    final int itemCount = isRecommended ? movies.length :12;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == movies.length && isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }
        return isTrending
            ? TrendingCard(
                width: cardWidth.toDouble(),
                movie: movies[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailsScreen.routeName,
                    arguments: movies[index].id,
                  );
                },
              )
            : SmallMovieCard(
                cardWidth: cardWidth.toDouble(),
                movie: movies[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailsScreen.routeName,
                    arguments: movies[index].id,
                  );
                },
              );
      },
    );
  }
}

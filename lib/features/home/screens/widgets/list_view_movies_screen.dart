import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movix/features/home/models/movie.dart';
import 'package:movix/features/home/screens/widgets/small_movie_card.dart';
import 'package:movix/features/home/screens/widgets/trending_card.dart';

class ListViewMoviesScreens extends StatelessWidget {
  const ListViewMoviesScreens({
    super.key,
    required ScrollController scrollController,
    required this.cardWidth,
    required this.movies,
    this.isTrending = false,
  }) : _scrollController = scrollController;

  

  final ScrollController _scrollController;
  final num cardWidth;
  final List<Movie> movies;
  bool get isLoading => movies.isEmpty;
  final bool isTrending;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemCount: 12,
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
                  log('Tapped movie: ${movies[index].title}');
                },
              )
            : SmallMovieCard(
                cardWidth: cardWidth.toDouble(),
                movie: movies[index],
                onTap: () {
                  log('Tapped movie: ${movies[index].title}');
                },
              );
      },
    );
  }
}

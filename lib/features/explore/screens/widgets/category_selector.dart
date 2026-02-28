
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/explore/cubit/explore_movies_cubit/explore_movies_cubit.dart';
import 'package:movix/features/explore/cubit/explore_movies_cubit/explore_movies_states.dart';
import 'package:movix/features/explore/screens/widgets/category_chip.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  final List<String> categories = const [
    "revenue",
    "vote_count",
    "primary_release_date",
  ];

  final List<String> categoryNames = const [
    "Revenue",
    "Vote Count", 
     "Release Date",
   
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExploreMoviesCubit, ExploreMoviesStates, String>(
      selector: (state) {
        return state.selectedCategory ?? categories[0];
      },
      builder: (context, activeCategory) {
        activeCategory = activeCategory.isEmpty ? categories[0] : activeCategory;
     
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            return Expanded(
              child: CategoryChip(
                isSelected: categories[index] == activeCategory,
                categoryName: categoryNames[index],
                onTap: () {
                  log(categories[index]);
                  context.read<ExploreMoviesCubit>().fetchExploreMovies(
                    refresh: activeCategory == categories[index] ? false : true,
                    category: categories[index],
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }
}

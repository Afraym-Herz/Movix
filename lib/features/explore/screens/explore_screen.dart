import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/sliver_grid_view_builder.dart';
import 'package:movix/features/explore/cubit/explore_movies_cubit/explore_movies_cubit.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/features/explore/cubit/explore_movies_cubit/explore_movies_states.dart';
import 'package:movix/features/explore/screens/widgets/category_selector.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) =>
          ExploreMoviesCubit(getIt.get<MovieRepository>())
            ..fetchExploreMovies(category: 'revenue'),
      child: Scaffold(
        backgroundColor: AppColors.lightRedBackground,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CategorySelector(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            BlocBuilder<ExploreMoviesCubit, ExploreMoviesStates>(
              builder: (context, state) {
                return SliverGridViewBuilder(
                  screenWidth: screenWidth,
                  shows: state.exploreMovies,
                  isLoading: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

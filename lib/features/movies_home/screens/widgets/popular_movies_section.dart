import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/popular_movies_cubit/popular_movies_states.dart';
import 'package:movix/features/movies_home/screens/popular_movies_screen.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final popularMoviesCubit = context.read<PopularMoviesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: popularMoviesCubit,
              child: const PopularMoviesScreen(),
            ),
          ),
        );
      },
      title: "Popular Movies",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesStates>(
          builder: (context, state) {
            if (state.popularIsLoading && state.popularMovies.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.popularMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<PopularMoviesCubit>().fetchPopularMovies(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<PopularMoviesCubit>().fetchPopularMovies(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.popularMovies,
                isTrending: false,
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/top_rated_movies_cubit/top_rated_movies_states.dart';
import 'package:movix/features/movies_home/screens/top_rated_movies_screen.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';

class TopRatedSection extends StatelessWidget {
  const TopRatedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final topRatedCubit = context.read<TopRatedMoviesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: topRatedCubit,
              child: const TopRatedMoviesScreen(),
            ),
          ),
        );
      },
      title: "Top Rated Movies",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesStates>(
          builder: (context, state) {
            

            if (state.errorMessage != null && state.topRatedMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<TopRatedMoviesCubit>().fetchTopRatedMovies(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<TopRatedMoviesCubit>().fetchTopRatedMovies(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.topRatedMovies,
                isTrending: false,
              ),
            );
          },
        ),
      ),
    );
  }
}

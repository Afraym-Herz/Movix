import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/up_coming_movies_cubit/up_coming_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/up_coming_movies_cubit/up_coming_movies_states.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';
import 'package:movix/features/movies_home/screens/up_coming_movies_screen.dart';

class UpComingSection extends StatelessWidget {
  const UpComingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final upComingCubit = context.read<UpComingMoviesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: upComingCubit,
              child: const UpComingMoviesScreen(),
            ),
          ),
        );
      },
      title: "Up Coming Movies",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<UpComingMoviesCubit, UpComingMoviesStates>(
          builder: (context, state) {

            if (state.errorMessage != null && state.upComingMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<UpComingMoviesCubit>().fetchUpComingMovies(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<UpComingMoviesCubit>().fetchUpComingMovies(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.upComingIsLoading ? [] : state.upComingMovies ,
                isTrending: false,
              ),
            );
          },
        ),
      ),
    );
  }
}

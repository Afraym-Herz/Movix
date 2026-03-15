import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/paggination_wrapper.dart';
import 'package:movix/features/movies_home/cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import 'package:movix/features/movies_home/cubits/now_playing_movies_cubit/now_playing_movies_states.dart';
import 'package:movix/features/movies_home/screens/now_playing_movies_screen.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_shows_screen.dart';
import 'package:movix/core/widgets/section_wrapper.dart';

class NowPlayingSection extends StatelessWidget {
  const NowPlayingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final nowPlayingCubit = context.read<NowPlayingMoviesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: nowPlayingCubit,
              child: const NowPlayingMoviesScreen(),
            ),
          ),
        );
      },
      title: "Now Playing Movies",
      child: SizedBox(
        height: cardHeight + 20,
        child: BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesStates>(
          builder: (context, state) {
            if (state.errorMessage != null && state.nowPlayingMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies(
                      refresh: true,
                    );
                  },
                ),
              );
            }

            return PagginationWrapper(
              onLoadMore: () =>
                  context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies(),
              child: ListViewShowsScreens(
                cardWidth: cardWidth,
                shows: state.nowPlayingMovies,
                isTrending: false,
              ),
            );
          },
        ),
      ),
    );
  }
}

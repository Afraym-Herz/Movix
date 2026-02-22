import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/home/cubits/popular_movies_cubit/popular_movies_states.dart';
import 'package:movix/features/home/screens/popular_screen.dart';
import 'package:movix/features/home/screens/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_movies_screen.dart';
import 'package:movix/features/home/screens/widgets/section_wrapper.dart';

class PopularSection extends StatefulWidget {
  const PopularSection({super.key});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PopularMoviesCubit>().fetchPopularMovies();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PopularMoviesCubit>().fetchPopularMovies();
    }
  }

  void _refreshMovies() {
    context.read<PopularMoviesCubit>().fetchPopularMovies(refresh: true);
  }

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
        height: cardHeight + 70,
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesStates>(
          builder: (context, state) {
            if (state.popularIsLoading && state.popularMovies.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.popularMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: _refreshMovies,
                ),
              );
            }

            return ListViewMoviesScreens(
              scrollController: _scrollController,
              cardWidth: cardWidth,
              movies: state.popularMovies,
              isTrending: false,
            );
          },
        ),
      ),
    );
  }
}

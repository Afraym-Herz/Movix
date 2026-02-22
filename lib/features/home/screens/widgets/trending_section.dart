import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/cubits/trendind_movies_cubit/trending_movies_cubit.dart';
import 'package:movix/features/home/cubits/trendind_movies_cubit/trending_movies_states.dart';
import 'package:movix/features/home/screens/trending_screen.dart';
import 'package:movix/features/home/screens/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_movies_screen.dart';
import 'package:movix/features/home/screens/widgets/section_wrapper.dart';

class TrendingSection extends StatefulWidget {
  const TrendingSection({super.key});

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TrendingMoviesCubit>().fetchTrendingMovies();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<TrendingMoviesCubit>().fetchTrendingMovies();
    }
  }

  void _refresh() {
    context.read<TrendingMoviesCubit>().fetchTrendingMovies(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth > 400 ? 200 : screenWidth * 0.44;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final trendingMoviesCubit = context.read<TrendingMoviesCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: trendingMoviesCubit,
              child: const TrendingMoviesScreen(),
            ),
          ),
        );
      },
      title: "Trending Movies",
      child: SizedBox(
        height: cardHeight + 70,
        child: BlocBuilder<TrendingMoviesCubit, TrendingMoviesStates>(
          builder: (context, state) {
            if (state.trendingIsLoading && state.trendingMovies.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.trendingMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: _refresh,
                ),
              );
            }

            return ListViewMoviesScreens(
              scrollController: _scrollController,
              cardWidth: cardWidth,
              movies: state.trendingMovies,
              isTrending: true,
            );
          },
        ),
      ),
    );
  }
}

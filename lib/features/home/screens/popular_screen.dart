import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/features/home/cubits/popular_movies_cubit/popular_movies_cubit.dart';
import 'package:movix/features/home/screens/widgets/sliver_app_bar.dart';
import 'package:movix/features/home/screens/widgets/grid_view_builder.dart';

import '../cubits/popular_movies_cubit/popular_movies_states.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  static const String routeName = '/popular-movies';

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,

      body: BlocBuilder<PopularMoviesCubit, PopularMoviesStates>(
        builder: (context, state) {
          if (state.popularIsLoading && state.popularMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.popularMovies.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _refreshMovies(),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),

              slivers: [
                buildSliverAppBar(context, title: "Popular Movies"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                SliverToBoxAdapter(
                  child: GridViewBuilder(
                    screenWidth: screenWidth,
                    movies: state.popularMovies,
                    isLoading: state.popularIsLoading,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/features/home/screens/widgets/sliver_app_bar.dart';
import 'package:movix/features/home/screens/widgets/grid_view_builder.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_cubit.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_state.dart';

class RecommendedMoviesScreen extends StatefulWidget {
  const RecommendedMoviesScreen({super.key, required this.movieId});

  static const String routeName = '/recommended-movies';
  final int movieId;

  @override
  State<RecommendedMoviesScreen> createState() => _RecommendedMoviesScreenState();
}

class _RecommendedMoviesScreenState extends State<RecommendedMoviesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    context.read<RecommendationMoviesCubit>().fetchRecommendedMovies(movieId: widget.movieId);
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
      context.read<RecommendationMoviesCubit>().fetchRecommendedMovies(movieId: widget.movieId);
    }
  }

  void _refreshMovies() {
    context.read<RecommendationMoviesCubit>().fetchRecommendedMovies(movieId: widget.movieId, refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<RecommendationMoviesCubit, RecommendationMoviesState>(
        builder: (context, state) {
           if (state.recommendedIsLoading && state.recommendedMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
    
          if (state.errorMessage != null && state.recommendedMovies.isEmpty) {
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
                buildSliverAppBar(context, title: "Recommended Movies"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
            
                SliverToBoxAdapter(
                  child: GridViewBuilder(
                    screenWidth: screenWidth,
                    movies: state.recommendedMovies,
                    isLoading: state.recommendedIsLoading,
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

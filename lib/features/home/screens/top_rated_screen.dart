import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/features/home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/home/cubits/top_rated_movies_cubit/top_rated_movies_states.dart';
import 'package:movix/features/home/screens/widgets/sliver_app_bar.dart';
import 'package:movix/features/home/screens/widgets/grid_view_builder.dart';

class TopRatedMoviesScreen extends StatefulWidget {
  const TopRatedMoviesScreen({super.key});

  static const String routeName = '/top-rated-movies';

  @override
  State<TopRatedMoviesScreen> createState() => _TopRatedMoviesScreenState();
}

class _TopRatedMoviesScreenState extends State<TopRatedMoviesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
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
      context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
    }
  }

  void _refreshMovies() {
    context.read<TopRatedMoviesCubit>().fetchTopRatedMovies(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesStates>(
        builder: (context, state) {
           if (state.topRatedIsLoading && state.topRatedMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
    
          if (state.errorMessage != null && state.topRatedMovies.isEmpty) {
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
                buildSliverAppBar(context, title: "Top Rated Movies"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
            
                SliverToBoxAdapter(
                  child: GridViewBuilder(
                    screenWidth: screenWidth,
                    movies: state.topRatedMovies,
                    isLoading: state.topRatedIsLoading,
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

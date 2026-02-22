import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/features/home/cubits/trendind_movies_cubit/trending_movies_cubit.dart';
import 'package:movix/features/home/cubits/trendind_movies_cubit/trending_movies_states.dart';
import 'package:movix/features/home/screens/widgets/sliver_app_bar.dart';
import 'package:movix/features/home/screens/widgets/sliver_grid_view_builder.dart';

class TrendingMoviesScreen extends StatefulWidget {
  const TrendingMoviesScreen({super.key});
  static const String routeName = '/trending-movies';

  @override
  State<TrendingMoviesScreen> createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    context.read<TrendingMoviesCubit>().fetchTrendingMovies();

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
      context.read<TrendingMoviesCubit>().fetchTrendingMovies();
    }
  }

  Future<void> _refresh() async {
    context.read<TrendingMoviesCubit>().fetchTrendingMovies(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      
      body: BlocBuilder<TrendingMoviesCubit, TrendingMoviesStates>(
        builder: (context, state) {
          if (state.trendingIsLoading && state.trendingMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
    
          if (state.errorMessage != null && state.trendingMovies.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
    
          return RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
            
              slivers: [
                buildSliverAppBar(context, title: "Trending Movies"),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
            
                SliverGridViewBuilder(
                  screenWidth: screenWidth,
                  movies: state.trendingMovies,
                  isLoading: state.trendingIsLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

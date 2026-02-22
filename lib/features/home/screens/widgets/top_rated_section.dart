import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/cubits/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movix/features/home/cubits/top_rated_movies_cubit/top_rated_movies_states.dart';
import 'package:movix/features/home/screens/top_rated_screen.dart';
import 'package:movix/features/home/screens/widgets/custom_error_message_loading.dart';
import 'package:movix/core/widgets/list_view_movies_screen.dart';
import 'package:movix/features/home/screens/widgets/section_wrapper.dart';

class TopRatedSection extends StatefulWidget {
  const TopRatedSection({super.key});

  @override
  State<TopRatedSection> createState() => _TopRatedSectionState();
}

class _TopRatedSectionState extends State<TopRatedSection> {
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
    final cardWidth = screenWidth > 600 ? 200 : screenWidth * 0.36;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      onSeeAllTap: () {
        final topRatedCubit = context.read<TopRatedMoviesCubit>();
        Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(
          value: topRatedCubit,
          child: const TopRatedMoviesScreen(),
        )));
      },
      title: "Top Rated Movies",
      child: SizedBox(
        height: cardHeight + 70,
        child: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesStates>(
          builder: (context, state) {
            if (state.topRatedIsLoading && state.topRatedMovies.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
    
            if (state.errorMessage != null && state.topRatedMovies.isEmpty) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: _refreshMovies,
                ),
              );
            }
    
            return  ListViewMoviesScreens(
              scrollController: _scrollController,
              cardWidth: cardWidth,
              movies: state.topRatedMovies,
              isTrending: false,
            );
          },
        ),
      ),
    );
  }
}

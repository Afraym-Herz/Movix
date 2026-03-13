import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/features/movie_details/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_cubit.dart';
import 'package:movix/features/movie_details/repositories/movie_details_repository.dart';
import 'package:movix/features/movie_details/screens/widgets/details_grid.dart';
import 'package:movix/features/movie_details/screens/widgets/movie_genres.dart';
import 'package:movix/features/movie_details/screens/widgets/movie_header.dart';
import 'package:movix/features/movie_details/screens/widgets/movie_overview.dart';
import 'package:movix/features/movie_details/screens/widgets/movie_tagline.dart';
import 'package:movix/features/movie_details/screens/widgets/production_company_row_movie.dart';
import 'package:movix/features/movie_details/screens/widgets/recommended_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movieId});

  final int movieId;
  static const routeName = '/movie-details';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieDetailsCubit(getIt<MovieDetailsRepository>())
            ..fetchMovieDetails(movieId),
        ),
        BlocProvider(
          create: (context) => getIt<RecommendationMoviesCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state.isLoading && state.movieDetails == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.movieDetails != null) {
              final movie = state.movieDetails!;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 400,
                    pinned: true,
                    backgroundColor: AppColors.primary,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (movie.fullBackdropUrl != null)
                            Image.network(
                              movie.fullBackdropUrl!,
                              fit: BoxFit.cover,
                            ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.primary,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        MovieDetailsScreenHeader(movieDetails: movie),
                        const SizedBox(height: 16),
                        if (movie.tagline != null && movie.tagline!.isNotEmpty)
                          MovieDetailsScreenTagline(tagline: movie.tagline!),
                        const SizedBox(height: 16),
                        MovieDetailsScreenGenres(movieDetails: movie),
                        const SizedBox(height: 24),
                        MovieDetailsScreenOverview(movieOverview: movie.overview),
                        const SizedBox(height: 24),
                        MovieDetailsScreenDetailsGrid(movieDetails: movie),
                        const SizedBox(height: 24),
                        ProductionCompaniesRowMovie(
                          movieDetailsModel: movie,
                        ),
                        const SizedBox(height: 32),
                        RecommendedSection(movieId: movie.id),
                        const SizedBox(height: 32),
                      ]),
                    ),
                  ),
                ],
              );
            } else if (state.errorMessage != null) {
              return Center(
                child: CustomErrorMessageLoading(
                  errorMessage: state.errorMessage!,
                  onRefresh: () {
                    context.read<MovieDetailsCubit>().fetchMovieDetails(movieId);
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

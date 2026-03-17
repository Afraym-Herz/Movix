import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/movie_repository.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/features/movie_details/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movix/features/movie_details/cubits/rating_movie_cubit/rating_movie_cubit.dart';
import 'package:movix/features/movie_details/cubits/recommendation_movies_cubit/cubit/recommendation_movies_cubit.dart';
import 'package:movix/features/movie_details/repositories/movie_details_repository.dart';
import 'package:movix/features/movie_details/screens/widgets/custom_movie_sliver_app_bar.dart';
import 'package:movix/features/movie_details/screens/widgets/details_grid.dart';
import 'package:movix/features/movie_details/screens/widgets/movie_genres.dart';
import 'package:movix/features/movie_details/screens/widgets/movie_header.dart';
import 'package:movix/features/movie_details/screens/widgets/movie_overview.dart';
import 'package:movix/features/movie_details/screens/widgets/production_company_row_movie.dart';
import 'package:movix/features/movie_details/screens/widgets/rating_movie_builder_bar.dart';
import 'package:movix/features/movie_details/screens/widgets/recommended_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = '/movie_details';

  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) =>
          MovieDetailsCubit(getIt.get<MovieDetailsRepository>())
            ..fetchMovieDetails(movieId),
      child: Scaffold(
        backgroundColor: AppColors.lightRedBackground,

        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final errorMessage = state.errorMessage;
            if (errorMessage != null) {
              return CustomErrorMessageLoading(
                errorMessage: errorMessage,
                onRefresh: () => context
                    .read<MovieDetailsCubit>()
                    .fetchMovieDetails(movieId),
              );
            }

            final movieDetails = state.movieDetails;
            if (movieDetails != null) {
              return CustomScrollView(
                slivers: [
                  CustomMovieSliverAppBar(
                    fullBackdropUrl: movieDetails.fullBackdropUrl,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          const SizedBox(height: 16),
                          MovieDetailsScreenHeader(
                            movieDetails: movieDetails,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MovieDetailsScreenGenres(
                              movieDetails: movieDetails,
                            ),
                          ),
                          const SizedBox(height: 22),
                          MovieDetailsScreenOverview(
                            movieOverview: movieDetails.overview,
                          ),
                          const SizedBox(height: 16),
                          BlocProvider(
                            create: (context) => RatingMovieCubit(getIt.get<MovieDetailsRepository>()) ,
                            child: RatingMovieBuilderBar(
                              movie: movieDetails
                            ),
                          ),
                          const SizedBox(height: 22),
                          MovieDetailsScreenDetailsGrid(
                            movieDetails: movieDetails,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ProductionCompaniesRowMovie(
                              movieDetailsModel: movieDetails,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocProvider(
                      create: (context) => RecommendationMoviesCubit(
                        getIt.get<MovieRepository>(),
                      ),
                      child: RecommendedSection(movieId: movieId),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('No movie details found'));
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/features/tv_series_details/cubits/tv_series_details_cubit/tv_series_details_cubit.dart';
import 'package:movix/features/tv_series_details/cubits/tv_series_details_cubit/tv_series_details_state.dart';
import 'package:movix/features/tv_series_details/repositories/tv_series_details_repository.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_genres.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_header.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_overview.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_tagline.dart';

class TvSeriesDetailsScreen extends StatelessWidget {
  const TvSeriesDetailsScreen({super.key, required this.tvSeriesId});

  final int tvSeriesId;
  static const routeName = '/tv-series-details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TVSeriesDetailsCubit(getIt<TVSeriesDetailsRepository>())
        ..fetchTVSeriesDetails(tvSeriesId),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocBuilder<TVSeriesDetailsCubit, TVSeriesDetailsState>(
          builder: (context, state) {
            if (state.isLoading && state.tvSeriesDetails == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.tvSeriesDetails != null) {
              final tvSeries = state.tvSeriesDetails!;
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
                          if (tvSeries.fullBackdropUrl != null)
                            Image.network(
                              tvSeries.fullBackdropUrl!,
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
                        TVSeriesDetailsScreenHeader(tvSeriesDetails: tvSeries),
                        const SizedBox(height: 16),
                        if (tvSeries.tagline != null && tvSeries.tagline!.isNotEmpty)
                          TVSeriesDetailsScreenTagline(tagline: tvSeries.tagline!),
                        const SizedBox(height: 16),
                        TVSeriesDetailsScreenGenres(tvSeriesDetails: tvSeries),
                        const SizedBox(height: 24),
                        TVSeriesDetailsScreenOverview(tvSeriesOverview: tvSeries.overview),
                        const SizedBox(height: 32),
                        // Add more sections here if needed (e.g., seasons, cast, recommendations)
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
                    context.read<TVSeriesDetailsCubit>().fetchTVSeriesDetails(tvSeriesId);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/widgets/custom_error_message_loading.dart';
import 'package:movix/features/tv_series_details/cubits/rating_tv_serie/rating_tv_series_cubit.dart';
import 'package:movix/features/tv_series_details/cubits/recommended_tv_series_cubit/recommended_tv_series_cubit.dart';
import 'package:movix/features/tv_series_details/cubits/tv_series_details_cubit/tv_series_details_cubit.dart';
import 'package:movix/features/tv_series_details/cubits/tv_series_details_cubit/tv_series_details_states.dart';
import 'package:movix/features/tv_series_details/repositories/tv_series_details_repository.dart';
import 'package:movix/features/tv_series_details/screens/widgets/custom_tv_series_sliver_app_bar.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_details_screen_details_grid.dart';
import 'package:movix/features/tv_series_details/screens/widgets/production_companies_row_tv_series.dart';
import 'package:movix/features/tv_series_details/screens/widgets/rating_tv_series_builder_bar.dart';
import 'package:movix/features/tv_series_details/screens/widgets/recommended_tv_series_section.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_genres.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_header.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_overview.dart';

class TVSeriesDetailsScreen extends StatelessWidget {
  static const routeName = '/tv-series-details-screen';

  const TVSeriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tvSeriesId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) =>
          TVSeriesDetailsCubit(getIt.get<TVSeriesDetailsRepository>())
            ..fetchTVSeriesDetails(tvSeriesId),
      child: Scaffold(
        backgroundColor: AppColors.lightRedBackground,

        body: BlocBuilder<TVSeriesDetailsCubit, TVSeriesDetailsStates>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return CustomErrorMessageLoading(
                errorMessage: state.errorMessage!,
                onRefresh: () => context
                    .read<TVSeriesDetailsCubit>()
                    .fetchTVSeriesDetails(tvSeriesId),
              );
            }

            if (state.tvSeriesDetails != null) {
              return CustomScrollView(
                slivers: [
                  CustomTVSeriesSliverAppBar(
                    fullBackdropUrl: state.tvSeriesDetails!.fullBackdropUrl,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          const SizedBox(height: 16),
                          TVSeriesDetailsScreenHeader(
                            tvSeriesDetails: state.tvSeriesDetails!,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TVSeriesDetailsScreenGenres(
                              tvSeriesDetails: state.tvSeriesDetails!,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BlocProvider(
                            create: (context) => RatingTVSeriesCubit(
                              getIt.get<TVSeriesDetailsRepository>(),
                            ),
                            child: RatingTVSeriesBuilderBar(
                              tvSeriesId: tvSeriesId,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TVSeriesDetailsScreenOverview(
                            tvSeriesOverview: state.tvSeriesDetails!.overview,
                          ),
                          const SizedBox(height: 22),
                          TVSeriesDetailsScreenDetailsGrid(
                            tvSeriesDeatilsModel: state.tvSeriesDetails!,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ProductionCompaniesRowTVSeries(
                              tvSeriesDetails: state.tvSeriesDetails!,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocProvider(
                      create: (context) => RecommendedTVSeriesCubit(
                        getIt.get<TVSeriesRepository>(),
                      )..fetchRecommendedTVSeries(tvSeriesId: tvSeriesId),
                      child: RecommendedTVSeriesSection(tvSeriesId: tvSeriesId),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('No tv series details found'));
          },
        ),
      ),
    );
  }
}


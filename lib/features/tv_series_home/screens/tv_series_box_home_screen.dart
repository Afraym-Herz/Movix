import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/widgets/custom_divider.dart';
import 'package:movix/core/widgets/header_home_screen.dart';
import 'package:movix/features/tv_series_home/cubits/airing_today_cubit/airing_today_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/on_the_air_tv_series_cubit/on_the_air_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/popular_tv_series_cubit/popular_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/cubits/top_rated_tv_series_cubit/top_rated_tv_series_cubit.dart';
import 'package:movix/features/tv_series_home/screens/widgets/airing_today_tv_series_section.dart';
import 'package:movix/features/tv_series_home/screens/widgets/on_the_air_tv_series_section.dart';
import 'package:movix/features/tv_series_home/screens/widgets/popular_tv_series_section.dart';
import 'package:movix/features/tv_series_home/screens/widgets/top_rated_tv_series_section.dart';

class TVSeriesBoxHomeScreen extends StatelessWidget {
  const TVSeriesBoxHomeScreen({super.key});

  static const routeName = '/tv-series-box-home-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HeaderHomeScreen()),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  AiringTVSeriesCubit(getIt.get<TVSeriesRepository>())
                    ..fetchAiringTodayTVSeries(),
              child: const AiringTodayTvSeriesSection(),
            ),
          ),

          const SliverToBoxAdapter(child: CustomDivider()),
          
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  PopularTVSeriesCubit(getIt.get<TVSeriesRepository>())
                    ..fetchPopularTVSeries(),
              child: const PopularTVSeriesSection(),
            ),
          ),
          
          const SliverToBoxAdapter(child: CustomDivider()),
          
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  TopRatedTVSeriesCubit(getIt.get<TVSeriesRepository>())
                    ..fetchTopRatedTVSeries(),
              child: const TopRatedTVSeriesSection(),
            ),
          ),
          
          const SliverToBoxAdapter(child: CustomDivider()),
          
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  OnTheAirTvSeriesCubit(getIt.get<TVSeriesRepository>())
                    ..fetchOnTheAirTVSeries(),
              child: const OnTheAirTvSeriesSection(),
            ),
          ),
        ],
      ),
    );
  }
}

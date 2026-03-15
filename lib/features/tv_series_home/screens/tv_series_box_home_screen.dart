import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/repositories/tv_series_repository.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/widgets/custom_divider.dart';
import 'package:movix/core/widgets/header_home_screen.dart';
import 'package:movix/features/tv_series_home/cubits/airing_today_cubit/airing_today_tv_series_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AiringTodayTVSeriesCubit(getIt.get<TVSeriesRepository>())
                ..fetchAiringTodayTVSeries(),
        ),
        BlocProvider(
          create: (context) =>
              PopularTVSeriesCubit(getIt.get<TVSeriesRepository>())
                ..fetchPopularTVSeries(),
        ),
        BlocProvider(
          create: (context) =>
              TopRatedTVSeriesCubit(getIt.get<TVSeriesRepository>())
                ..fetchTopRatedTVSeries(),
        ),
        BlocProvider(
          create: (context) =>
              OnTheAirTVSeriesCubit(getIt.get<TVSeriesRepository>())
                ..fetchOnTheAirTVSeries(),
        ),
      ],
      child: const SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: AiringTodayTvSeriesSection()),
            SliverToBoxAdapter(child: CustomDivider()),
            SliverToBoxAdapter(child: PopularTVSeriesSection()),
            SliverToBoxAdapter(child: CustomDivider()),
            SliverToBoxAdapter(child: TopRatedTVSeriesSection()),
            SliverToBoxAdapter(child: CustomDivider()),
            SliverToBoxAdapter(child: OnTheAirTvSeriesSection()),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/models/show_model.dart';
import 'package:movix/core/models/tv_series_model.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:movix/features/explore/screens/explore_screen.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/movies_home/screens/movie_box_home_screen.dart';
import 'package:movix/features/saved_movies/screens/saved_movies_screen.dart';
import 'package:movix/features/search/cubit/search_cubit.dart';
import 'package:movix/features/search/repos/search_repo.dart';
import 'package:movix/features/search/screens/widgets/search_loaded_view.dart';
import 'package:movix/features/search/screens/widgets/search_separated_screens.dart' hide SearchLoadedView;
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';
import 'package:movix/features/tv_series_home/screens/tv_series_box_home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  static const routeName = '/main-layout';

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;
  final SearchController searchController = SearchController();

  late final SearchCubit searchCubit;

  final List<Widget> pages = const [
    MovieBoxHomeScreen(),
    TVSeriesBoxHomeScreen(),
    ExploreScreen(),
    SavedMovieScreen(),
  ];

  @override
  void initState() {
    super.initState();
    searchCubit = SearchCubit(getIt.get<SearchRepo>());
    searchController.addListener(() {
      searchCubit.searchMethod(showTitle: searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchCubit.close();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  void _navigate(BuildContext context, ShowModel show) {
    if (show is MovieModel) {
      Navigator.pushNamed(
        context,
        MovieDetailsScreen.routeName,
        arguments: show.id,
      );
    } else if (show is TVSeriesModel) {
      Navigator.pushNamed(
        context,
        TVSeriesDetailsScreen.routeName,
        arguments: show.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().currentUser;

    return BlocProvider.value(
      value: searchCubit,
      child: Scaffold(
        backgroundColor: AppColors.lightRedBackground,

        appBar: buildAppBar(
          context: context,
          userName: user?.username ?? '',
          imageUrl: user?.avatarUrl ?? '',
          onSearchTap: () => searchController.openView(),
        ),

        body: SearchAnchor(
          searchController: searchController,
          viewBackgroundColor: AppColors.lightRedBackground,
          dividerColor: const Color(0xFF2A2A2A),
          headerHintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          headerTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          viewHintText: 'Search movies, TV shows, and more...',

          viewLeading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => searchController.closeView(''),
          ),

          builder: (context, controller) {
            return IndexedStack(
              index: selectedIndex,
              children: pages,
            );
          },

          suggestionsBuilder: (context, controller) {
            return [
              BlocBuilder<SearchCubit, SearchCubitState>(
                bloc: searchCubit,
                builder: (context, state) {
                  return switch (state) {
                    SearchCubitInitial() => const SearchInitialView(),
                    SearchCubitLoading() => const SearchLoadingView(),
                    SearchCubitSuccess() => SearchLoadedView(
                        results: state.shows!,
                        onTap: (show) {
                          controller.closeView('');
                          _navigate(context, show);
                        },
                      ),
                    SearchCubitEmpty() => SearchEmptyView(
                        query: controller.text,
                      ),
                    SearchCubitFailure() => SearchFailureView(
                        message: state.errMessage,
                      ),
                    SearchCubitState() => const SizedBox.shrink(),
                  };
                },
              ),
            ];
          },
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  NavigationBar _buildBottomNavBar() {
    return NavigationBar(
      onDestinationSelected: _onItemTapped,
      backgroundColor: AppColors.lightRedBackground,
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: AppColors.primary),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.tv_outlined),
          selectedIcon: Icon(Icons.tv, color: AppColors.primary),
          label: 'TV Series',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore, color: AppColors.primary),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline),
          selectedIcon: Icon(Icons.bookmark, color: AppColors.primary),
          label: 'Saved',
        ),
      ],
      animationDuration: const Duration(milliseconds: 500),
      elevation: 0,
      indicatorColor: AppColors.primary.withAlpha(20), // ✅ was 2 too transparent
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelTextStyle: WidgetStateProperty.all(
        AppTextStyles.semiBold14(context).copyWith(color: Colors.white),
      ),
    );
  }
}

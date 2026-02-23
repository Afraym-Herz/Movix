import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/explore/screens/explore_screen.dart';
import 'package:movix/features/home/screens/movie_box_home_screen.dart';
import 'package:movix/features/profile/screens/profile_screen.dart';
import 'package:movix/features/saved_movie/screens/saved_movie_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  static const routeName = "/main-layout";

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;
  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = const [
    MovieBoxHomeScreen(),
    ExploreScreen(),
    SavedMovieScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightRedBackground,
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  NavigationBar buildBottomNavBar() {
    return NavigationBar(
      onDestinationSelected: _onItemTapped ,
      backgroundColor: AppColors.lightRedBackground,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: AppColors.primary),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore, color: AppColors.primary),
          label: "Explore",
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline),
          selectedIcon: Icon(Icons.bookmark, color: AppColors.primary),
          label: "Saved",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person, color: AppColors.primary),
          label: "Profile",
        ),
      ],
      animationDuration: const Duration(milliseconds: 500),
      elevation: 0,
      indicatorColor: AppColors.primary.withAlpha(2),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelTextStyle: WidgetStateProperty.all(
        AppTextStyles.semiBold14(context).copyWith(color: Colors.white),
      ),
      selectedIndex: selectedIndex,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
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
      body: IndexedStack(
        index: selectedIndex ,
        children: pages),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  

  BottomNavigationBar buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.lightRedBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: "Explore",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }



}

import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  static const routeName = '/explore-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightRedBackground,
        body: Center(
          child: Text(
            'Explore',
            style: AppTextStyles.semiBold24(context).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

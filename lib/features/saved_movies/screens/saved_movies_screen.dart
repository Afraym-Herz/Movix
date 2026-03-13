import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class SavedMovieScreen extends StatelessWidget {
  const SavedMovieScreen({super.key});

  static const routeName = '/saved-movies-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightRedBackground,
        body: Center(
          child: Text(
            'Saved Movies',
            style: AppTextStyles.semiBold24(context).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

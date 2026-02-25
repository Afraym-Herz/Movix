
import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class MovieDetailsScreenOverview extends StatelessWidget {
  const MovieDetailsScreenOverview({
    super.key,
    required this.movieOverview,
  });

  final String movieOverview;

  @override
  Widget build(BuildContext context) {
    if (movieOverview.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 24, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Overview',
              style: AppTextStyles .bold16(context).copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          movieOverview,
          style: AppTextStyles.regular14(
            context,
          ).copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }
}

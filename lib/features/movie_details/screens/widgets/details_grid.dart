import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';
import 'package:movix/features/movie_details/screens/widgets/details_grid_item.dart';

class MovieDetailsScreenDetailsGrid extends StatelessWidget {
  const MovieDetailsScreenDetailsGrid({super.key, required this.movieDetails});

  final MovieDetailsModel movieDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 24, color: AppColors.primary),
            const SizedBox(width: 8),
             Text(
              'Details',
              style: AppTextStyles.bold16(context).copyWith(color: Colors.white) ,
            ),
          ],
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.7,
          crossAxisSpacing: 16,
          children: [
            MovieDetailsScreenDetailsItem(
              label: 'Budget',
              value: movieDetails.formattedBudget,
            ),
            MovieDetailsScreenDetailsItem(
              label: 'Revenue',
              value: movieDetails.formattedRevenue,
            ),
            MovieDetailsScreenDetailsItem(
              label: 'Status',
              value: movieDetails.status,
            ),
            if (movieDetails.originalLanguage.isNotEmpty)
              MovieDetailsScreenDetailsItem(
                label: 'Language',
                value: movieDetails.originalLanguage.toUpperCase(),
              ),
          ],
        ),
      ],
    );
  }
}

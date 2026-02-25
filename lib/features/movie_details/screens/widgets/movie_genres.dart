
import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';

class MovieDetailsScreenGenres extends StatelessWidget {
  const MovieDetailsScreenGenres({
    super.key,
    required this.movieDetails,
  });

  final MovieDetailsModel movieDetails;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start ,
      spacing: 8,
      runSpacing: 4,
      children: movieDetails.genres.map<Widget>((genre) {
        return Chip(
          label: Text(
            genre.name,
            style: AppTextStyles.regular11(context).copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.lightRedBackground.withAlpha(240),
        );
      }).toList(),
    );
  }
}

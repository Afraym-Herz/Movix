
import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

class TVSeriesDetailsScreenGenres extends StatelessWidget {
  const TVSeriesDetailsScreenGenres({
    super.key,
    required this.tvSeriesDetails,
  });

  final TVSeriesDetailsModel tvSeriesDetails;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start ,
      spacing: 8,
      runSpacing: 4,
      children: tvSeriesDetails.genres.map<Widget>((genre) {
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

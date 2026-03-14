import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';
import 'package:movix/features/tv_series_details/screens/widgets/tv_series_details_item.dart';

class TVSeriesDetailsScreenDetailsGrid extends StatelessWidget {
  const TVSeriesDetailsScreenDetailsGrid({super.key, required this.tvSeriesDeatilsModel});

  final TVSeriesDetailsModel tvSeriesDeatilsModel;

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
            
            TVSeriesScreenDetailsItem(
              label: 'Status',
              value: tvSeriesDeatilsModel.status,
            ),
            TVSeriesScreenDetailsItem(
              label: 'Seasons',
              value: tvSeriesDeatilsModel.numberOfSeasons.toString(),
            ),
            TVSeriesScreenDetailsItem(
              label: 'Episodes',
              value: tvSeriesDeatilsModel.numberOfEpisodes.toString(),
            ),
            TVSeriesScreenDetailsItem(
              label: 'Release Year',
              value: tvSeriesDeatilsModel.airYear ?? 'N/A',
            ),
            if (tvSeriesDeatilsModel.originalLanguage.isNotEmpty)
              TVSeriesScreenDetailsItem(
                label: 'Language',
                value: tvSeriesDeatilsModel.originalLanguage.toUpperCase(),
              ),
          ],
        ),
      ],
    );
  }
}

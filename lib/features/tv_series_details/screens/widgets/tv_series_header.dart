
import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

class TVSeriesDetailsScreenHeader extends StatelessWidget {
  const TVSeriesDetailsScreenHeader({
    super.key,
    required this.tvSeriesDetails,
  });

  final TVSeriesDetailsModel tvSeriesDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tvSeriesDetails.name,
          style: AppTextStyles.bold26(context).copyWith(
            color: Colors.white,
          ),
        ),
        if (tvSeriesDetails.originalName != tvSeriesDetails.name) ...[
          const SizedBox(height: 4),
          Text(
            'Original: ${tvSeriesDetails.originalName}',
            style: AppTextStyles.regular16(context).copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ],
        if (tvSeriesDetails.lastAirDate != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.star, size: 24, color: Colors.amber.shade700),
              const SizedBox(width: 2),
              Text(
                tvSeriesDetails.voteAverage.toStringAsFixed(1),
                style: AppTextStyles.bold20(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${tvSeriesDetails.voteCount} votes)',
                style: AppTextStyles.regular14(context).copyWith(
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                tvSeriesDetails.lastAirDate!,
                style: AppTextStyles.regular14(context).copyWith(color: Colors.white),
              ),
              if (tvSeriesDetails.episodeRunTime != null) ...[
                const SizedBox(width: 16),
                Icon(Icons.schedule, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  tvSeriesDetails.episodeRunTime.toString(),
                  style: AppTextStyles.regular14(context).copyWith(color: Colors.white),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

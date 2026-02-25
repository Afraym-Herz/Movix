
import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';

class MovieDetailsScreenHeader extends StatelessWidget {
  const MovieDetailsScreenHeader({
    super.key,
    required this.movieDetails,
  });

  final MovieDetailsModel movieDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movieDetails.title,
          style: AppTextStyles.bold26(context).copyWith(
            color: Colors.white,
          ),
        ),
        if (movieDetails.originalTitle != movieDetails.title) ...[
          const SizedBox(height: 4),
          Text(
            'Original: ${movieDetails.originalTitle}',
            style: AppTextStyles.regular16(context).copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ],
        if (movieDetails.releaseDate != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.star, size: 24, color: Colors.amber.shade700),
              const SizedBox(width: 2),
              Text(
                movieDetails.voteAverage.toStringAsFixed(1),
                style: AppTextStyles.bold20(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${movieDetails.voteCount} votes)',
                style: AppTextStyles.regular14(context).copyWith(
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                movieDetails.releaseDate!,
                style: AppTextStyles.regular14(context).copyWith(color: Colors.white),
              ),
              if (movieDetails.runtime != null) ...[
                const SizedBox(width: 16),
                Icon(Icons.schedule, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  movieDetails.formattedRuntime!,
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

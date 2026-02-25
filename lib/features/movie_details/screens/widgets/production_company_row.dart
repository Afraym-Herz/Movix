import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/movie_details/models/movie_details_model.dart';

class ProductionCompanies extends StatelessWidget {
  const ProductionCompanies({super.key, required this.movieDetails});

  final MovieDetailsModel movieDetails;

  @override
  Widget build(BuildContext context) {
    if (movieDetails.productionCompanies.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
              Container(width: 4, height: 24, color: AppColors.primary),
              const SizedBox(width: 8),
            Text(
              'Production Companies',
              style: AppTextStyles.bold16(context).copyWith(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment:  WrapAlignment.start,
          children: [
            for (var company in movieDetails.productionCompanies)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (company.fullLogoUrl != null)
                    Image.network(
                      company.fullLogoUrl!,
                      height: 20,
                      color:  Colors.white,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
                    )
                  else
                     Row(
                      children: [
                        const Icon(Icons.business, size: 24, color: Colors.white),
                        const SizedBox(width: 4),
                         Text(
                          company.name ,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  const SizedBox(width: 4),
                  
                ],
              ),
          ],
        ),
      ],
    );
  }
}

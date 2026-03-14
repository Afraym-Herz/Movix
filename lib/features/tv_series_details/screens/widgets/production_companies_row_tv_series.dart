import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

class ProductionCompaniesRowTVSeries extends StatelessWidget {
  const ProductionCompaniesRowTVSeries({
    super.key,
    required this.tvSeriesDetails,
  });

  final TVSeriesDetailsModel tvSeriesDetails;

  @override
  Widget build(BuildContext context) {
    if (tvSeriesDetails.productionCompanies.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Production Companies',
          style: AppTextStyles.bold16(context).copyWith(color: Colors.white),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tvSeriesDetails.productionCompanies.length,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final company = tvSeriesDetails.productionCompanies[index];
              return company.fullLogoPath != null
                  ? Image.network(
                      company.fullLogoPath!,
                      height: 50,
                      fit: BoxFit.contain,
                      color: Colors.white,
                      errorBuilder: (context, error, stackTrace) => Text(
                        company.name,
                        style: AppTextStyles.regular14(context)
                            .copyWith(color: Colors.white),
                      ),
                    )
                  : Center(
                      child: Text(
                        company.name,
                        style: AppTextStyles.regular14(context)
                            .copyWith(color: Colors.white),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}

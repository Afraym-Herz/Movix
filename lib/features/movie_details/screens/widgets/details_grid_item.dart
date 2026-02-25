
import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class MovieDetailsScreenDetailsItem extends StatelessWidget {
  const MovieDetailsScreenDetailsItem({
    super.key, required this.label, required this.value,
    
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.regular12(context).copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.regular14(context).copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

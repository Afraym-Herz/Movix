import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric( horizontal: 62 , vertical: 14),
      child: Divider(
        color: AppColors.primary.withValues(alpha: 0.4),
        thickness: 1.2,
      ),
    );
  }
}
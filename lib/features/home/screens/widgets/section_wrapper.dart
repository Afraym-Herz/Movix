import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class SectionWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSeeAllTap;

  const SectionWrapper({super.key, required this.title, required this.child,required this.onSeeAllTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bold20(
                  context,
                ).copyWith(color: Colors.white),
              ),
               GestureDetector(
                 onTap: onSeeAllTap,
                 child: const Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                               ),
               ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

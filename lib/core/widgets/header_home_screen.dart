import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class HeaderHomeScreen extends StatelessWidget {
  const HeaderHomeScreen({super.key, this.title = 'Movix'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.semiBold24(context).copyWith(
              color: AppColors.primary,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          const Icon(Icons.notifications_outlined, color: Colors.white),
        ],
      ),
    );
  }
}

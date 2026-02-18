import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/home/screens/widgets/logo_box.dart';

class HeaderHomeScreen extends StatelessWidget {
  const HeaderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const LogoBox(),
              const SizedBox(width: 8),
              Text(
                "MOVIE",
                style: AppTextStyles.bold19(
                  context,
                ).copyWith(color: Colors.white, letterSpacing: 1.2),
              ),
              Text(
                "X",
                style: AppTextStyles.bold19(
                  context,
                ).copyWith(color: AppColors.primary),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.search, color: Colors.grey[400]),
              const SizedBox(width: 16),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

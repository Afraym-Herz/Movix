import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/utils/assets.dart';

class IdentifiyAndSecurTextContainer extends StatelessWidget {
  const IdentifiyAndSecurTextContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.imagesConfirmImage),
        const SizedBox(height: 24),
        SizedBox(
          width: 300,
          child: Text(
            'Account registration and authentication is handled securely by The Movie Database (TMDB).',
            style: AppTextStyles.regular14(
              context,
            ).copyWith(color: AppColors.greyColor, letterSpacing: 1.5, height: 1.6),
            maxLines: 10,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

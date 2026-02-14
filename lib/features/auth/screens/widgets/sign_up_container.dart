import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/auth/screens/widgets/sign_up_button.dart';

class SignUpContainer extends StatelessWidget {
  const SignUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 18 , vertical: 15),
            child: Text(
              'Don’t have an account? Registration is managed externally through TMDB.',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14(
                context,
              ).copyWith(color: const Color(0xffCBD5E1)),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
           SignUpButton(text: 'Create Account on TMDB', onPressed: () {
            log( 'Create Account on TMDB');
            },),
           const SizedBox(height: 20,),
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class OrDividerRow extends StatelessWidget {
  const OrDividerRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xff333333),
            thickness: 1.2,
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'NEW ENTHUSIST?',
            style: AppTextStyles.medium12(context).copyWith(
              color: AppColors.greyColor, 
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xff333333),
            thickness: 1.2,
          ),
        ),
      ],
    );
  }
}

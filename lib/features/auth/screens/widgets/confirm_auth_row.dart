import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class ConfirmAuthRow extends StatelessWidget {
  const ConfirmAuthRow({
    super.key,
    required this.question,
    required this.actionText,
    required this.action,
  });
  final String question;
  final String actionText;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: AppTextStyles.regular12(context).copyWith(color: AppColors.greyColor),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: action,
          child: Text(actionText, style: AppTextStyles.medium12(context).copyWith(color: AppColors.primary)),
        ),
      ],
    );
  }
}

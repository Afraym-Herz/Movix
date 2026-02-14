import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50 ,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primary),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          overlayColor: WidgetStateProperty.all(
            AppColors.primary,
          ),
          elevation: WidgetStateProperty.all(0),

        ),
        onPressed: onPressed,
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: AppTextStyles.bold16(context),
        ),
      ),
    );
  }
}

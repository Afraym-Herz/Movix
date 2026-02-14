import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50 ,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: AppColors.primary),
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              text,
              style: AppTextStyles.semiBold14(
                context,
              ).copyWith(color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.open_in_new, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

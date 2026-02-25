
import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';

class MovieDetailsScreenTagline extends StatelessWidget {
  const MovieDetailsScreenTagline({
    super.key,
    required this.tagline,
  });

  final String tagline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
    
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightRedBackground.withAlpha(240),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withAlpha(100)),
      ),
      child: Text(
        '"$tagline"',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),
      ),
    );
  }
}

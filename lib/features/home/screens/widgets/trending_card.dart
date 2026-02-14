import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';

class TrendingCard extends StatelessWidget {
  const TrendingCard({super.key, required this.width});
  final double width ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 160 / 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    "https://picsum.photos/400/600",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50914),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "TRENDING",
                        style: AppTextStyles.bold10(context).copyWith(
                          color: Colors.white
                        ) ,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Dark Horizon",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16 , color: Colors.white),
          ),
          const SizedBox(height: 1),
           Row(
            children: [
              const Icon(Icons.star,
                  color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text("8.9",
                  style: AppTextStyles.semiBold13(context).copyWith(color: Colors.white)),
              const SizedBox(width: 8),
              Text("• Action",
                  style: AppTextStyles.regular14(context).copyWith(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}

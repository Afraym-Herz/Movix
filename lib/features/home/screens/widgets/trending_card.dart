import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/features/home/models/movie.dart';

class TrendingCard extends StatelessWidget {
  const TrendingCard({
    super.key,
    required this.width,
    required this.movie,
    required this.onTap,
  });
  final double width;
  final Movie movie;
  final Function() onTap;

  @override
    Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    movie.fullPosterUrl != null
                        ? Image.network(
                            movie.fullPosterUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(Icons.broken_image_outlined, size: 48),
                            ),
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                          )
                        : const Center(
                            child: Icon(Icons.movie_outlined, size: 48),
                          ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE50914),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "TRENDING",
                          style: AppTextStyles.bold8(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 1),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: AppTextStyles.semiBold13(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  "• ${movie.releaseYear}",
                  style: AppTextStyles.regular14(
                    context,
                  ).copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

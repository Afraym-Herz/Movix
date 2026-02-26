import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/models/show.dart';

class SmallMovieCard extends StatelessWidget {
  const SmallMovieCard({
    super.key,
     this.cardWidth,
    required this.movie,
    required this.onTap,
  });
  final double? cardWidth;
  final Show movie;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth != null ? cardWidth! -32 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: movie.fullPosterUrl != null
                    ? Image.network(
                        movie.fullPosterUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                            ? child
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.broken_image_outlined, size: 48),
                        ),
                      )
                    : const Center(child: Icon(Icons.movie_outlined, size: 48)),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis ,
              style: AppTextStyles.bold14(context).copyWith(color: Colors.white),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 13),
                const SizedBox(width: 4),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: AppTextStyles.semiBold13(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  movie.releaseYear ?? 'Unknown',
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

import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_text_styles.dart';

import 'package:movix/core/widgets/app_network_image.dart';

class SmallShowCard extends StatelessWidget {
  const SmallShowCard({
    super.key,
    this.cardWidth,
    required this.show,
    required this.onTap,
    this.userRating,
  });
  final double? cardWidth;
  final dynamic show;
  final VoidCallback onTap;
  final double? userRating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth != null ? cardWidth! - 32 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: show.fullPosterUrl != null
                    ? AppNetworkImage(
                        imageUrl: show.fullPosterUrl,
                        width: cardWidth,
                        fit: BoxFit.cover,
                      )
                    : const Center(child: Icon(Icons.movie_outlined, size: 48)),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              show.disPlayTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bold14(
                context,
              ).copyWith(color: Colors.white),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 13),
                const SizedBox(width: 4),
                Text(
                  show.voteAverage.toStringAsFixed(1),
                  style: AppTextStyles.semiBold13(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  show.releaseYear ?? 'Unknown',
                  style: AppTextStyles.regular14(
                    context,
                  ).copyWith(color: Colors.grey),
                ),
              ],
            ),
            if (userRating != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Your Rating: ',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Icon(Icons.star, color: Colors.blue, size: 12),
                  const SizedBox(width: 2),
                  Text(
                    userRating!.toStringAsFixed(1),
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

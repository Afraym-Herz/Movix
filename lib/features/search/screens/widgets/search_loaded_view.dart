// ── Initial ──────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/models/show_model.dart';
import 'package:movix/core/widgets/app_network_image.dart';


// ── Loading ──────────────────────────────────────

// ── Loaded ───────────────────────────────────────
class SearchLoadedView extends StatelessWidget {
  final List<ShowModel> results;
  final ValueChanged<ShowModel> onTap;

  const SearchLoadedView({super.key, 
    required this.results,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: results.map((show) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AppNetworkImage(
                  imageUrl: show.fullPosterUrl,
                  width: 45,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                show.disPlayTitle ,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    show.releaseYear ?? 'Unknown',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  if (show.voteAverage > 0) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.star, color: Colors.amber, size: 12),
                    const SizedBox(width: 2),
                    Text(
                      show.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ],
              ),
              trailing: _MediaTypeBadge(show: show),
              onTap: () => onTap(show),
            ),
            const Divider(color: Color(0xFF2A2A2A), height: 1),
          ],
        );
      }).toList(),
    );
  }
  }

class _MediaTypeBadge extends StatelessWidget {
  final ShowModel show;
  const _MediaTypeBadge({required this.show});

  @override
  Widget build(BuildContext context) {
    final (label, color) = show is MovieModel
        ? ('Movie', Colors.blue)
        : ('TV', Colors.purple);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withAlpha(5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11),
      ),
    );
  }
}

// ── Initial ──────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/models/show_model.dart';
import 'package:movix/core/widgets/app_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchInitialView extends StatelessWidget {
  const SearchInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_filter_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Search for movies, shows & people',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// ── Loading ──────────────────────────────────────
class SearchLoadingView extends StatelessWidget {
  const SearchLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Row(
          children: [
            Container(
              width: 60,
              height: 85,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14, width: 150, color: const Color(0xFF2A2A2A)),
                  const SizedBox(height: 8),
                  Container(height: 10, width: 80, color: const Color(0xFF2A2A2A)),
                  const SizedBox(height: 8),
                  Container(height: 10, width: 60, color: const Color(0xFF2A2A2A)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const Divider(color: Color(0xFF2A2A2A)),
      itemBuilder: (context, index) {
        final show = results[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,

          // ✅ Poster
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AppNetworkImage(
              imageUrl: show.fullPosterUrl,
              width: 45,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Title
          title: Text(
            show.disPlayTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          // ✅ Year + rating
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

          // ✅ Media type badge
          trailing: _MediaTypeBadge(show: show),

          onTap: () => onTap(show),
        );
      },
    );
  }
}

// ── Empty ─────────────────────────────────────────
class SearchEmptyView extends StatelessWidget {
  final String query;
  const SearchEmptyView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No results for "$query"',
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try different keywords',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ── Failure ───────────────────────────────────────
class SearchFailureView extends StatelessWidget {
  final String message;
  const SearchFailureView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.grey, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── MediaType Badge ───────────────────────────────
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

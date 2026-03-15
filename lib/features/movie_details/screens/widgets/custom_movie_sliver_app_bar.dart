import 'package:flutter/material.dart';

class CustomMovieSliverAppBar extends StatelessWidget {
  const CustomMovieSliverAppBar({
    super.key,
    required this.fullBackdropUrl,
  });

  final String? fullBackdropUrl;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: fullBackdropUrl != null
            ? Image.network(
                fullBackdropUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              )
            : Container(color: Colors.grey[900]),
      ),
    );
  }
}

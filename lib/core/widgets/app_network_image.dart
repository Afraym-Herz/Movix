import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      fit: fit,
      width: width,
      height: height,

      // ✅ Skeleton placeholder
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: const Color(0xFF2A2A2A),
      ),

      // ✅ Error state
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: const Color(0xFF2A2A2A),
        child: const Center(
          child: Icon(
            Icons.broken_image_outlined,
            size: 48,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }
}

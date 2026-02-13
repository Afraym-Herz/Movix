import 'package:flutter/material.dart';
import 'package:movix/core/widgets/background_image_container.dart';

class BackgroundImageStack extends StatelessWidget {
  const BackgroundImageStack({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImageContainer(),
        SafeArea(child:child),
      ],
    );
  }
}
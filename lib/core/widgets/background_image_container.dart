import 'package:flutter/material.dart';
import 'package:movix/core/utils/assets.dart';

class BackgroundImageContainer extends StatelessWidget {
  const BackgroundImageContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
          image:  DecorationImage(
            image: AssetImage(Assets.imagesBlackBackgroundWithRed),
            fit: BoxFit.fill,
          ),
        ),
    );
  }
}
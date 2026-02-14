import 'package:flutter/material.dart';
import 'package:movix/features/home/screens/widgets/section_wrapper.dart';
import 'package:movix/features/home/screens/widgets/trending_card.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth > 600 ? 200 : screenWidth * 0.44 ;
    final cardHeight = cardWidth * 1.5;
    return SectionWrapper(
      title: "Trending Movies",
      child: SizedBox(
        height: cardHeight+70,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) =>  TrendingCard(
            width:  cardWidth,
          ),
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemCount: 10,
        ),
      ),
    );
  }
}

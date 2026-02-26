import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';

SliverAppBar buildSliverAppBar(BuildContext context, {required String title}) {
  return SliverAppBar(
    centerTitle: true,
    floating: true,
    snap: true,
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: SizedBox.shrink(),
    ),
    title: Text(
      title,
      style: AppTextStyles.bold23(context).copyWith(color: Colors.white),
    ),
    backgroundColor: AppColors.lightRedBackground,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
  );
}

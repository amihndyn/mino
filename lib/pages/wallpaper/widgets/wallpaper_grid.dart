import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_sizes.dart';

class WallpaperGrid extends StatelessWidget {
  final List<String> wallpapers;

  const WallpaperGrid({
    super.key,
    required this.wallpapers,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      itemCount: wallpapers.length,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.md,
        mainAxisSpacing: AppSizes.md,
        childAspectRatio: 0.62,
      ),

      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(
            AppSizes.cardRadius,
          ),

          child: Image.asset(
            wallpapers[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
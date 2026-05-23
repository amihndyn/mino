import 'package:flutter/material.dart';import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import 'widgets/wallpaper_grid.dart';

class WallpaperPage
    extends StatelessWidget {
  const WallpaperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final wallpapers = [
      'assets/images/wall1.jpg',
      'assets/images/wall2.jpg',
      'assets/images/wall3.jpg',
      'assets/images/wall4.jpg',
    ];

    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Wallpaper',

          style:
              AppTextStyles.pageTitleBold,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        child: WallpaperGrid(
          wallpapers: wallpapers,
        ),
      ),
    );
  }
}
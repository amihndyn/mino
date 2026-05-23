import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

import '../../widgets/appbars/custom_appbar.dart';

class WallpaperPage extends StatelessWidget {
  const WallpaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: const CustomAppBar(
        title: 'Wallpaper',
        showBackButton: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),

        child: GridView.builder(
          itemCount: 8,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.md,
            mainAxisSpacing: AppSizes.md,
            childAspectRatio: 0.62,
          ),

          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppSizes.cardRadius,
                ),

                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/wallpaper.jpg',
                  ),

                  fit: BoxFit.cover,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.18,
                    ),

                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Align(
                alignment: Alignment.bottomCenter,

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(
                    AppSizes.md,
                  ),

                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(
                      bottom: Radius.circular(
                        AppSizes.cardRadius,
                      ),
                    ),

                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.75),
                      ],
                    ),
                  ),

                  child: const Text(
                    'Calm Aesthetic',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
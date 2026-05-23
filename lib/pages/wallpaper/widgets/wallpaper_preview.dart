import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

class WallpaperPreview extends StatelessWidget {
  final String image;

  const WallpaperPreview({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      body: Stack(
        children: [
          // IMAGE
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),

          // DARK OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(
                0.25,
              ),
            ),
          ),

          // BACK BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                AppSizes.lg,
              ),

              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },

                child: Container(
                  width: 48,
                  height: 48,

                  decoration: BoxDecoration(
                    color:
                        Colors.black.withOpacity(
                      0.35,
                    ),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
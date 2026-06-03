import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class ChooseAvatarPage extends StatelessWidget {
  const ChooseAvatarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // List path diubah ekstensinya menjadi .png
    final avatars = [
      'assets/images/man.png',
      'assets/images/astronot.png',
      'assets/images/woman.png',
    ];

    return Scaffold(
      backgroundColor: AppColors.coklat900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Choose Avatar',
          style: AppTextStyles.pageTitleBold,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),
        itemCount: avatars.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppSizes.lg,
          mainAxisSpacing: AppSizes.lg,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.orange400,
                  width: 2,
                ),
              ),
              // Menggunakan ClipOval + Image.asset agar gambar PNG terpotong sempurna menjadi lingkaran
              child: ClipOval(
                child: Image.asset(
                  avatars[index],
                  fit: BoxFit.cover,
                  // Pengaman jika gambar gagal dimuat, menampilkan icon avatar default
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.account_circle,
                      color: AppColors.orange400,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
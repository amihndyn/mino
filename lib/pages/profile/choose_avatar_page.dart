import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class ChooseAvatarPage
    extends StatelessWidget {
  const ChooseAvatarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final avatars = [
      'assets/images/avatar1.png',
      'assets/images/avatar2.png',
      'assets/images/avatar3.png',
      'assets/images/avatar4.png',
      'assets/images/avatar5.png',
      'assets/images/avatar6.png',
    ];

    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Choose Avatar',

          style:
              AppTextStyles.pageTitleBold,
        ),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        itemCount: avatars.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing:
              AppSizes.lg,
          mainAxisSpacing:
              AppSizes.lg,
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
                  color:
                      AppColors.orange400,
                  width: 2,
                ),
              ),

              child: CircleAvatar(
                backgroundImage:
                    AssetImage(
                  avatars[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
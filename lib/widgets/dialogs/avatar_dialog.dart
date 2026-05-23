import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

class AvatarDialog extends StatelessWidget {
  final List<String> avatars;
  final Function(String) onSelected;

  const AvatarDialog({
    super.key,
    required this.avatars,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,

      child: Container(
        padding: const EdgeInsets.all(
          AppSizes.xl,
        ),

        decoration: BoxDecoration(
          color: AppColors.coklat800,

          borderRadius: BorderRadius.circular(
            AppSizes.radiusLg,
          ),

          border: Border.all(
            color: AppColors.coklat600,
          ),
        ),

        child: GridView.builder(
          shrinkWrap: true,

          itemCount: avatars.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSizes.md,
            mainAxisSpacing: AppSizes.md,
          ),

          itemBuilder: (context, index) {
            final avatar = avatars[index];

            return GestureDetector(
              onTap: () {
                onSelected(avatar);
                Navigator.pop(context);
              },

              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    AssetImage(avatar),
              ),
            );
          },
        ),
      ),
    );
  }
}
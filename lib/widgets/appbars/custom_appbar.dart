import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.appBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.coklat900,
        border: Border(
          bottom: BorderSide(
            color: AppColors.coklat700.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.coklat800,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    border: Border.all(color: AppColors.coklat600, width: 1),
                  ),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.orange200,
                    size: 22,
                  ),
                ),
              )
            else
              const SizedBox(width: 36),
            const SizedBox(width: AppSizes.sm),
            Expanded(child: Text(title, style: AppTextStyles.pageTitleBold)),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}

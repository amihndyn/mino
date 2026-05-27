import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // NAVBAR BG
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.coklat800.withValues(alpha: 0.95),
                        AppColors.coklat900.withValues(alpha: 0.92),
                      ],
                    ),
                    border: Border.all(
                      color: AppColors.orange300.withValues(alpha: 0.25),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.45),
                        blurRadius: 30,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _NavItem(
                        icon: Icons.home_rounded,
                        label: 'Today',
                        isActive: currentIndex == 0,
                        onTap: () => onTap(0),
                      ),

                      _NavItem(
                        icon: Icons.menu_book_rounded,
                        label: 'Journal',
                        isActive: currentIndex == 1,
                        onTap: () => onTap(1),
                      ),

                      const SizedBox(width: 70),

                      _NavItem(
                        icon: Icons.flag_rounded,
                        label: 'Challenge',
                        isActive: currentIndex == 3,
                        onTap: () => onTap(3),
                      ),

                      _NavItem(
                        icon: Icons.person_rounded,
                        label: 'Profile',
                        isActive: currentIndex == 4,
                        onTap: () => onTap(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // CENTER BUTTON
          Positioned(
            top: -6,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFB97A3D),
                      Color(0xFF8A5527),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orange400.withValues(alpha: 0.45),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1DAAF2),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Color(0xFFFFD37A),
                    size: 36,
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

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFFFFD37A);
    final inactiveColor = const Color(0xFFE0BE8B);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? activeColor : inactiveColor,
                size: 22,
              ),

              const SizedBox(height: 4),

              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight:
                      isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),

              const SizedBox(height: 6),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: isActive ? 24 : 0,
                height: 3,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
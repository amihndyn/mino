import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

class JournalTabSwitch extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const JournalTabSwitch({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<JournalTabSwitch> createState() => _JournalTabSwitchState();
}

class _JournalTabSwitchState extends State<JournalTabSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _slideAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    if (widget.selectedIndex == 1) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(JournalTabSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      if (widget.selectedIndex == 1) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.coklat900.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(
          color: AppColors.coklat600.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // SLIDING BACKGROUND
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth / 2 - 4;
                    return Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          left: 4 + (_slideAnimation.value * (width + 0)),
                          top: 4,
                          child: Container(
                            width: width,
                            height: constraints.maxHeight - 8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.orange800,
                                  AppColors.orange900,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusMd,
                              ),
                              border: Border.all(
                                color: AppColors.orange600.withValues(alpha: 0.5),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.orange700.withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),

          // TAB BUTTONS
          Row(
            children: [
              _TabButton(
                label: 'Journal',
                isSelected: widget.selectedIndex == 0,
                onTap: () => widget.onChanged(0),
              ),
              _TabButton(
                label: 'Progress',
                isSelected: widget.selectedIndex == 1,
                onTap: () => widget.onChanged(1),
                
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.orange100 : AppColors.coklat300,
              shadows: isSelected
                  ? [
                      Shadow(
                        color: AppColors.orange500.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
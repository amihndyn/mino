import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/pages/journal/journal_page.dart';

class JournalCard extends StatefulWidget {
  final JournalEntry entry;
  final VoidCallback? onSeeNote;

  const JournalCard({
    super.key,
    required this.entry,
    this.onSeeNote,
  });

  @override
  State<JournalCard> createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onSeeNote,
      child: AnimatedBuilder(
        animation: _glowController,
        builder: (context, child) {
          final glowValue = _glowController.value;
          final glowOpacity = 0.3 + (glowValue * 0.3);

          return AnimatedScale(
            scale: _isPressed ? 0.96 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.coklat800.withValues(alpha: 0.85),
                    AppColors.coklat900.withValues(alpha: 0.95),
                  ],
                ),
                border: Border.all(
                  color: AppColors.orange700.withValues(alpha: glowOpacity),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.orange900.withValues(alpha: glowOpacity * 0.6),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.cardRadius - 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER - Day name & number
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSizes.md,
                        AppSizes.md,
                        AppSizes.md,
                        AppSizes.sm,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            widget.entry.dayName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.coklat300,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            '${widget.entry.dayNumber}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.orange100,
                              shadows: [
                                Shadow(
                                  color: AppColors.orange500.withValues(alpha: 0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // MOOD SECTION
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm,
                        ),
                        padding: const EdgeInsets.all(AppSizes.md),
                        decoration: BoxDecoration(
                          color: AppColors.coklat700.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                          border: Border.all(
                            color: AppColors.coklat600.withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Mood label
                            Text(
                              'Mood',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.orange300,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: AppSizes.sm),

                            // Emoji
                            Text(
                              widget.entry.moodEmoji,
                              style: const TextStyle(fontSize: 36),
                            ),
                            const SizedBox(height: AppSizes.sm),

                            // Mood text
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.sm,
                                vertical: AppSizes.xs,
                              ),
                              decoration: BoxDecoration(
                                color: widget.entry.moodColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                                border: Border.all(
                                  color: widget.entry.moodColor.withValues(alpha: 0.4),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                widget.entry.moodLabel,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: widget.entry.moodColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // BUTTON
                    Padding(
                      padding: const EdgeInsets.all(AppSizes.sm),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.sm + 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.orange900.withValues(alpha: 0.6),
                              AppColors.orange800.withValues(alpha: 0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                          border: Border.all(
                            color: AppColors.orange700.withValues(alpha: 0.5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.orange900.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'See my note',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.orange200,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: AppColors.orange300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
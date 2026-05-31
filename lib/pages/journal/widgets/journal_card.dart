import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_text_styles.dart';
import 'package:mino/models/journal_entry_model.dart.dart';


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

class _JournalCardState extends State<JournalCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onSeeNote,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          // Kembali ke ukuran compact (vertical 10)
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.orange900,
              width: 1.2,
            ),
            // Tetap mempertahankan shadow halus
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =====================
              // HEADER (HARI & TANGGAL)
              // =====================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget.entry.dayName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppColors.orange100,
                    ),
                  ),
                  
                  // Jarak horizontal antara hari dan tanggal
                  const SizedBox(width: 8), 

                  Text(
                    '${widget.entry.dayNumber}',
                    style: AppTextStyles.pageTitleBold.copyWith(
                      color: AppColors.orange100,
                      fontSize: 20, // Ukuran compact
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

// =====================
// MOOD CARD
// =====================
Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(vertical: 10), // Padding compact
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: AppColors.orange700.withValues(alpha: 0.6),
      width: 1,
    ),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.white.withValues(alpha: 0.06),
        AppColors.white.withValues(alpha: 0.01),
      ],
    ),
    // 🌟 MENAMBAHKAN SHADOW HALUS DI SINI
    boxShadow: [
      BoxShadow(
        color: AppColors.black.withValues(alpha: 0.12),
        blurRadius: 10,
        offset: const Offset(0, 4), // Arah bayangan sedikit ke bawah
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Mood',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.orange600,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        widget.entry.moodEmoji,
        style: const TextStyle(fontSize: 38), // Emoji compact
      ),
      const SizedBox(height: 4),
      Text(
        widget.entry.moodLabel,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.sectionTitleBold.copyWith(
          color: AppColors.orange600,
          fontSize: 15,
        ),
      ),
    ],
  ),
),

              // Jarak tombol disesuaikan (dikebawahin dikit tapi proporsional)
              const SizedBox(height: 25),

              // =====================
              // BUTTON SEE MY NOTE
              // =====================
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.orange200.withValues(alpha: 0.25),
                    width: 1,
                  ),
                  color: AppColors.white.withValues(alpha: 0.04),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See my note',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.orange400,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: AppColors.orange400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
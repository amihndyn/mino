import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_text_styles.dart';
import 'package:mino/models/journal_entry_model.dart';

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
              color: AppColors.orange400,
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
                      fontWeight: FontWeight.w400,
                      color: AppColors.orange100,
                      letterSpacing: 1
                    ),
                  ),
                  
                  // Jarak horizontal antara hari dan tanggal
                  const SizedBox(width: 8), 

                  Text(
                    '${widget.entry.dayNumber}',
                    style: AppTextStyles.pageTitleBold.copyWith(
                      color: AppColors.orange100,
                      fontSize: 20, // Ukuran compact
                      letterSpacing: 1
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // =====================
              // MOOD CARD
              // =====================
              // =====================
              // MOOD CARD
              // =====================
              Container(
                width: 104,  // 🔥 UBAH DARI double.infinity MENJADI 104
                height: 159, // 🔥 TAMBAHKAN TINGGI 159 DI SINI
                padding: const EdgeInsets.symmetric(vertical: 10), // Jika terlalu sesak, padding vertical bisa dikurangi/dihapus
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.orange400.withValues(alpha: 0.6),
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
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 🔥 UBAH KE CENTER agar isi mood pas di tengah kotak 159px
                  children: [
                    Text(
                      'Mood',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.orange400,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1
                      ),
                    ),
                    const SizedBox(height: 6),
                    
                    Image.asset(
                      widget.entry.moodEmoji,
                      width: 48, 
                      height: 48,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.sentiment_neutral_rounded,
                        color: Colors.grey,
                        size: 32,
                      ),
                    ),
                    
                    const SizedBox(height: 6),
                    Text(
                      widget.entry.moodLabel,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.sectionTitleBold.copyWith(
                        color: AppColors.orange400,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              // Jarak diperkecil sedikit agar tidak rentan overflow di layar kecil
              const SizedBox(height: 16),

              // =====================
              // BUTTON SEE MY NOTE
              // =====================
              Container(
                width: 132,  // 🔥 Lebar menjadi 132
                height: 39,  // 🔥 Tinggi menjadi 39
                alignment: Alignment.center, // 🌟 Memastikan isi tombol tetap di tengah
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.orange400.withValues(alpha: 0.25),
                    width: 1,
                  ),
                  color: AppColors.white.withValues(alpha: 0.04),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center, // 🌟 Menjaga row tetap di tengah
                  children: [
                    Text(
                      'See my note',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.orange400,
                        fontSize: 13,
                        letterSpacing: 1,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
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

class _JournalCardState extends State<JournalCard> {
  bool _isPressed = false;

  // =====================
  // CUSTOM COLORS
  // =====================
  final Color orangeBorder = const Color(0xFFF09E43);
  final Color textOrange = const Color(0xFFE28E35);
  final Color innerCardBorder = const Color(0xFFF5D6B4);
  final Color textDayLight = const Color(0xFFF7E2CC);
  final Color textDayDark = const Color(0xFFF1D1A9);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Efek scale saat card ditekan
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),

      onTap: widget.onSeeNote,

      child: AnimatedScale(
        // Card mengecil sedikit saat ditekan
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),

        child: Container(
          // Padding diperkecil supaya tinggi card lebih compact
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),

          decoration: BoxDecoration(
            // Background transparan
            // Semakin kecil alpha => semakin transparan
            color: Colors.transparent,

            // Radius diperkecil agar lebih compact
            borderRadius: BorderRadius.circular(28),

            border: Border.all(
              // Border dibuat lebih soft/transparan
              color: orangeBorder.withValues(alpha: 0.45),
              width: 1.2,
            ),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =====================
              // HEADER
              // =====================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${widget.entry.dayName} ',
                    style: TextStyle(
                      // Ukuran teks hari diperkecil
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textDayLight,
                    ),
                  ),

                  Text(
                    '${widget.entry.dayNumber}',
                    style: TextStyle(
                      // Ukuran angka tanggal diperkecil
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: textDayDark,
                    ),
                  ),
                ],
              ),

              // Jarak antar section diperkecil
              const SizedBox(height: 14),

              // =====================
              // MOOD CARD
              // =====================
              Container(
                width: double.infinity,

                // Padding diperkecil agar inner card tidak terlalu tinggi
                padding: const EdgeInsets.symmetric(vertical: 18),

                decoration: BoxDecoration(
                  // Radius inner card diperkecil
                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    // Border dibuat lebih transparan
                    color: innerCardBorder.withValues(alpha: 0.25),
                    width: 1,
                  ),

                  // Gradient transparan biar nyatu dengan bg utama
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.10),
                      Colors.white.withValues(alpha: 0.03),
                    ],
                  ),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Mood',
                      style: TextStyle(
                        // Ukuran label mood diperkecil
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: orangeBorder,
                      ),
                    ),

                    // Spacing diperkecil
                    const SizedBox(height: 10),

                    Text(
                      widget.entry.moodEmoji,

                      // Ukuran emoji diperkecil
                      // supaya tidak overflow
                      style: const TextStyle(fontSize: 42),
                    ),

                    // Spacing diperkecil
                    const SizedBox(height: 10),

                    Text(
                      widget.entry.moodLabel,

                      // Jika text terlalu panjang
                      // akan jadi titik titik (...)
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        // Ukuran text mood diperkecil
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textOrange,
                      ),
                    ),
                  ],
                ),
              ),

              // Jarak antar section diperkecil
              const SizedBox(height: 14),

              // =====================
              // BUTTON
              // =====================
              Container(
                // Padding button diperkecil
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),

                decoration: BoxDecoration(
                  // Radius button diperkecil
                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    // Border dibuat lebih soft/transparan
                    color: innerCardBorder.withValues(alpha: 0.3),
                    width: 1,
                  ),

                  // Background button transparan
                  color: Colors.white.withValues(alpha: 0.05),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See note',
                      style: TextStyle(
                        // Ukuran text button diperkecil
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: orangeBorder,
                      ),
                    ),

                    const SizedBox(width: 4),

                    Icon(
                      Icons.chevron_right_rounded,

                      // Ukuran icon diperkecil
                      size: 18,
                      color: orangeBorder,
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
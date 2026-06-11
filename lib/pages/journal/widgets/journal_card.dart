import 'package:flutter/material.dart';
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
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            // Border jingga keemasan transparan (efek glow tipis sesuai desain)
            border: Border.all(
              color: const Color(0xFFE6A84A).withValues(alpha: 0.5), 
              width: 1.5,
            ),
            image: const DecorationImage(
              image: AssetImage('assets/images/bg_journal.png'), 
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Baris Atas: Hari & Tanggal (contoh: "thursday 30")
              Text(
                "${widget.entry.dayName} ${widget.entry.dayNumber}",
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFF5E6D3),
                ),
              ),
              const SizedBox(height: 10),
              
              // 2. Baris Bawah: Emoji, Detail Mood, dan Tombol Note
              Row(
                children: [
                  // Lingkaran Emoji dengan Border Glow
                  Container(
                    width: 58,
                    height: 58,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE6A84A).withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.entry.moodEmoji,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.sentiment_neutral_rounded,
                          color: Colors.white70,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  
                  // Teks Deskripsi Mood
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'mood today',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          color: Color(0xFFE6A84A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.entry.moodLabel, // otomatis menampilkan "bad mood", "Amazing", dll
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  
                  // Tombol Pill "see my note ›"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8C6439).withValues(alpha: 0.8), // warna cokelat keemasan matang
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'see my note ',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            color: Color(0xFFF5E6D3),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '›',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: Color(0xFFF5E6D3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
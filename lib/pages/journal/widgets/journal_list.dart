import 'package:flutter/material.dart';
import 'package:mino/models/journal_entry_model.dart';
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/note_detail_page.dart'; 

class JournalGrid extends StatelessWidget {
  final List<JournalEntry> entries;
  final VoidCallback? onTapWeeklyReflection; // 🌟 Ditambahkan parameter ontap di sini

  const JournalGrid({
    super.key,
    required this.entries,
    this.onTapWeeklyReflection, // 🌟 Masukkan ke constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================================
        // 1. LIST JURNAL VERTIKAL (MENGGANTIKAN GRID)
        // ==========================================
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: entries.length,
          separatorBuilder: (context, index) => const SizedBox(height: 30),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return JournalCard(
              entry: entry,
              onSeeNote: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailPage(
                      noteTitle: entry.noteTitle,
                      noteContent: entry.noteContent,
                      fullDate: entry.fullDate,
                      mood: entry.moodEmoji,
                      moodLabel: entry.moodLabel,
                      moodColor: entry.moodColor,
                    ),
                  ),
                );
              },
            );
          },
        ),

        const SizedBox(height: 30), // Jarak antara list dan Weekly Reflection

        // ==========================================
        // 2. KARTU WEEKLY REFLECTION
        // ==========================================
        Container(
          width: double.infinity, 
          padding: const EdgeInsets.only(
            top: 23.0,
            left: 24.0,
            right: 24.0,
            bottom: 28.5,
          ),
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(width: 1, color: Color(0x33E6A84A)),
            ),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gradient: LinearGradient(
              transform: GradientRotation(3.14 * 0.38),
              colors: [Color(0x14E6A84A), Color(0x0D3FA7C4)],
              stops: [0, 1],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weekly Reflection',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.39,
                  color: Color(0xFFF5E6D3),
                ),
              ),
              const SizedBox(height: 15.75),
              Opacity(
                opacity: 0.8,
                child: const Text(
                  'This week, you stayed consistent and made meaningful progress toward your goals.',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    height: 1.5,
                    color: Color(0xFFF5E6D3),
                  ),
                ),
              ),
              const SizedBox(height: 15.75),
              // Tombol Variant3 yang sekarang dibungkus GestureDetector

            ],
          ),
        ),
      ],
    );
  }
}
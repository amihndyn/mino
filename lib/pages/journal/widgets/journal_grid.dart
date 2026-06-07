import 'package:flutter/material.dart';
import 'package:mino/models/journal_entry_model.dart';
// import 'package:mino/pages/journal/note_list_page.dart'; // Ini bisa dihapus kalau tidak dipakai lagi di sini
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/note_detail_page.dart'; // Pastikan import ini ada

class JournalGrid extends StatelessWidget {
  final List<JournalEntry> entries;

  const JournalGrid({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        // Masukkan rasio 160 (lebar) dibagi 305 (tinggi)
        childAspectRatio: 160 / 285, 
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return JournalCard(
          entry: entry,
          onSeeNote: () {
            // --- UBAH NAVIGASI DI SINI ---
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetailPage(
                  // Sesuaikan pemanggilan 'entry.xxx' dengan field yang ada di JournalEntry model-mu
                  noteTitle: entry.noteTitle, 
                  noteContent: entry.noteContent,
                  fullDate: entry.fullDate, // atau entry.createdAt, dll
                  mood: entry.moodEmoji, 
                  moodLabel: entry.moodLabel,
                  moodColor: entry.moodColor, 
                ),
              ),
            );
            // -----------------------------
          },
        );
      },
    );
  }
}
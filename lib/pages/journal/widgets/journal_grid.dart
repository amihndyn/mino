import 'package:flutter/material.dart';
import 'package:mino/models/journal_entry_model.dart.dart';
import 'package:mino/pages/journal/note_list_page.dart';
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/note_detail_page.dart';

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
        childAspectRatio: 0.78, // Rasio proporsional pas sesuai desain kartu mood
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return JournalCard(
          entry: entry,
          onSeeNote: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteListPage(),
              ),
            );
          },
        );
      },
    );
  }
}
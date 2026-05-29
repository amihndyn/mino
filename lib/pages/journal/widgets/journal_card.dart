import 'package:flutter/material.dart';
import '../journal_page.dart';

class JournalCard extends StatelessWidget {
  final JournalEntry entry;
  final VoidCallback onSeeNote;

  const JournalCard({
    super.key,
    required this.entry,
    required this.onSeeNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            entry.dayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            '${entry.dayNumber}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Text(
            entry.noteTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Text(entry.moodEmoji),

              const SizedBox(width: 6),

              Text(entry.moodLabel),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(
              onPressed: onSeeNote,

              child: const Text(
                'See Note',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
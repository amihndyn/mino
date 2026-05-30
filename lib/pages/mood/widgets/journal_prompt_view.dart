import 'package:flutter/material.dart';
import 'package:mino/pages/mood/write_journal_page.dart';


class JournalPromptView extends StatelessWidget {
  final String? selectedMood;
  final Function(String) onNoteAdded;

  const JournalPromptView({
    super.key,
    required this.selectedMood,
    required this.onNoteAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/blogjurnal.png', height: 30),
        const SizedBox(height: 20),
        const Text(
          'Do you want to write down\neverything in your heart?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF2A1A0E),
            fontSize: 17,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "It's not mandatory, but this will be very helpful",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF7A5C3E), fontSize: 13),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A1A0E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            onPressed: () async {
              final result = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (_) => const WriteJournalScreen(),
                  settings: RouteSettings(arguments: selectedMood),
                ),
              );
              
              if (result != null && result.isNotEmpty) {
                onNoteAdded(result);
              }
            },
            child: const Text(
              'Add note',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
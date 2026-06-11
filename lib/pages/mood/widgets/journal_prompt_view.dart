import 'package:flutter/material.dart';
import 'package:mino/pages/mood/write_journal_page.dart'; // Pastikan kelas di dalam file ini bernama WriteJournalScreen
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class JournalPromptView extends StatelessWidget {
  final String mood;
  final String moodLabel;
  final Color moodColor;
  final Function(String) onNoteAdded;

  const JournalPromptView({
    super.key,
    required this.mood,
    required this.moodLabel,
    required this.moodColor,
    required this.onNoteAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 412,
      margin: const EdgeInsets.symmetric(horizontal: 0.4), 
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6E3BC), 
        borderRadius: BorderRadius.circular(24), 
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/blog.png', 
            height: 200,
            width: 212,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 130,
              child: Center(
                child: Icon(
                  Icons.image_not_supported, 
                  color: AppColors.coklat900,
                  size: 32,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          const Text(
            'Do you want to write down\neverything in your heart?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.coklat900, 
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          const Text(
            "It's not mandatory, but this will be very helpful",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.coklat900, 
              fontSize: 12,
            ),
          ),
          
          const SizedBox(height: 20),
          
          SizedBox(
            width: 140, 
            height: 40, 
            child: CustomButton(
              text: 'Add note',
              onTap: () async {
                // Meneruskan data mood ke halaman WriteJournalScreen
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WriteJournalScreen(
                      mood: mood,
                      moodLabel: moodLabel,
                      moodColor: moodColor,
                    ),
                  ),
                );
                
                if (result != null && result.isNotEmpty) {
                  onNoteAdded(result);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
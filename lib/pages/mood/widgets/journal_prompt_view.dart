import 'package:flutter/material.dart';
import 'package:mino/pages/mood/write_journal_page.dart'; // Pastikan kelas di dalam file ini bernama WriteJournalScreen
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class JournalPromptView extends StatelessWidget {
  // 🔥 Variabel mood (UI Ami) + Logic 2 parameter (Sausan)
  final String mood;
  final String moodLabel;
  final Color moodColor;
  final Function(String title, String content) onNoteAdded; 

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
      margin: const EdgeInsets.symmetric(horizontal: 0.4), // UI Ami
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
                child: Icon(Icons.image_not_supported, color: AppColors.coklat900, size: 32),
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
            style: TextStyle(color: AppColors.coklat900, fontSize: 12),
          ),
          
          const SizedBox(height: 20),
          
          SizedBox(
            width: 140, 
            height: 40, 
            child: CustomButton(
              text: 'Add note',
              onTap: () async {
                // 🔥 Logic Sausan: Menangkap Map data dari halaman WriteJournalScreen
                final Map<String, String>? result = await Navigator.push<Map<String, String>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WriteJournalScreen(
                      // Mengirimkan UI parameter Ami ke halaman selanjutnya
                      mood: mood,
                      moodLabel: moodLabel,
                      moodColor: moodColor,
                    ),
                  ),
                );
                
                // Logic Sausan: Kirim data terpisah (title & content) ke parent state
                if (result != null && result['title'] != null && result['content'] != null) {
                  onNoteAdded(result['title']!, result['content']!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
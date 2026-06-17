import 'package:flutter/material.dart';
import 'package:mino/pages/mood/write_journal_page.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class JournalPromptView extends StatelessWidget {
  final String? selectedMood;
  final Function(String title, String content) onNoteAdded; // 🔥 Diubah agar menerima 2 parameter terpisah

  const JournalPromptView({
    super.key,
    required this.selectedMood,
    required this.onNoteAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 412,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6E3BC), 
        borderRadius: BorderRadius.circular(24), 
        // 🛠️ FIX: Tambahkan stroke border inside 2px warna coklat900 agar konsisten dengan komponen Figma lainnya
        border: Border.all(
          color: AppColors.coklat900,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
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
                // 🔥 Menangkap Map data dari halaman WriteJournalScreen
                final Map<String, String>? result = await Navigator.push<Map<String, String>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WriteJournalScreen(),
                    settings: RouteSettings(arguments: selectedMood),
                  ),
                );
                
                if (result != null && result['title'] != null && result['content'] != null) {
                  // Kirim data terpisah ke parent state
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
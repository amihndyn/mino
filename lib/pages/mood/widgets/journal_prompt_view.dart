import 'package:flutter/material.dart';
import 'package:mino/pages/mood/write_journal_page.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

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
    return Container(
      // 🔥 Lebar dan tinggi card diubah ke 370x412
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
        // 🔥 Tambahkan ini agar konten berada tepat di tengah card secara vertikal
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 3. DIUBAH KE PNG: Menggunakan Image.asset bawaan Flutter
          Image.asset(
            'assets/images/blog.png', 
            height: 200,
            width: 212,
            // Fallback jika file png belum ada di folder aset
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
          
          // 4. EDIT UKURAN BUTTON DI SINI: Bungkus dengan SizedBox kustom
          SizedBox(
            width: 140, // Ubah angka ini untuk mengatur kelebaran tombol kustom
            height: 40, // Ubah angka ini untuk mengatur tinggi tombol kustom
            child: CustomButton(
              text: 'Add note',
              onTap: () async {
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
            ),
          ),
        ],
      ),
    );
  }
}
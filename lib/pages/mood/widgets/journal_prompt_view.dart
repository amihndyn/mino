import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
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
      width: double.infinity,
      // 1. EDIT LEBAR CARD DI SINI: Makin kecil angka horizontal, card makin lebar ke samping
      margin: const EdgeInsets.symmetric(horizontal: 0.4), 
      
      // 2. EDIT TINGGI CARD DI SINI: Kurangi angka vertikal jika ingin card lebih pendek
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      
      decoration: BoxDecoration(
        color: const Color(0xFFF6E3BC), 
        borderRadius: BorderRadius.circular(24), 
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 3. EDIT UKURAN GAMBAR DI SINI: Diubah ke SVG menggunakan SvgPicture.asset
          SvgPicture.asset(
            'assets/images/blogjurnal.svg', 
            height: 130,
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
              color: AppColors.coklat900, // Warna teks soft cream kustom
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
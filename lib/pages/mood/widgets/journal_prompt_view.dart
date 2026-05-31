import 'package:flutter/material.dart';
import 'package:mino/pages/mood/write_journal_page.dart';
import 'package:mino/widgets/button/custom_button.dart';


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
          // 3. EDIT UKURAN GAMBAR DI SINI: Kecilkan height agar card ikut memendek
          Image.asset('assets/images/blogjurnal.png', height: 130),
          
          const SizedBox(height: 16),
          
          const Text(
            'Do you want to write down\neverything in your heart?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2A1A0E), 
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          
          const SizedBox(height: 8),
          
          const Text(
            "It's not mandatory, but this will be very helpful",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7A5C3E), 
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
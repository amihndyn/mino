import 'package:flutter/material.dart';
import 'package:mino/pages/mood/journaling_page.dart';
import 'package:mino/providers/moodjournal_provider.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:mino/pages/mood/widgets/mood_grid.dart';
import 'package:mino/pages/mood/widgets/mood_tile.dart';
// TODO: Pastikan untuk mengimpor file kustom tombolmu di sini, contoh:
// import 'package:mino/widgets/custom_button.dart'; 

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodPage> {
  String? _selectedMood;

  final List<MoodItem> _moods = const [
    MoodItem(imagePath: 'assets/images/reflection.png', label: 'Amazing'),
    MoodItem(imagePath: 'assets/images/reflection.png', label: 'Good'),
    MoodItem(imagePath: 'assets/images/reflection.png', label: 'Okey'),
    MoodItem(imagePath: 'assets/images/reflection.png', label: 'Unusual'),
    MoodItem(imagePath: 'assets/images/reflection.png', label: 'Bad'),
  ];

  void _onNext() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih mood kamu dulu ya 😊'),
          backgroundColor: Color(0xFF3D2B1F),
        ),
      );
      return;
    }

    context.read<MoodJournalProvider>().setMood(_selectedMood!);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const JournalingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Background utama aplikasi ──────────────────────────
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── Card pembungkus konten utama (Bottom Sheet Style) ──
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // Mengambil tinggi sekitar 88% layar agar bagian atas background tetap terlihat
              height: MediaQuery.of(context).size.height * 0.88,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1E1611), // Warna gelap senada dengan tema UI kamu
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                top: false, // Menghindari penambahan padding safearea di atas card kustom
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    
                    // ── Top Bar (Teks tengah & Cancel terkontrol) ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Add mood',
                              style: TextStyle(
                                color: Color(0xFFE8A838), // Warna gold soft kustom
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white60, 
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 2),

                    // ── Pertanyaan utama ─────────────────────────────
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'How is your mood\ntoday?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF3D59B), // Warna teks soft cream kustom
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.35,
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // ── Grid Emojis ──────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: MoodGrid(
                        moods: _moods,
                        selectedMood: _selectedMood,
                        onMoodSelected: (moodLabel) {
                          setState(() => _selectedMood = moodLabel);
                        },
                      ),
                    ),

                    const Spacer(flex: 4),

                    // ── Tombol Bawah menggunakan CustomButton ─────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: CustomButton(
                          text: 'Next',
                          onTap: _onNext,
                          // Catatan: Jika CustomButton milikmu memiliki parameter kustom 
                          // untuk mengubah warna aktif/tidak, kamu bisa menyelipkannya di sini.
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
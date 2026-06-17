import 'package:flutter/material.dart';
import 'package:mino/pages/mood/journaling_page.dart';
import 'package:mino/providers/moodjournal_provider.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/pages/mood/widgets/mood_grid.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:provider/provider.dart';

// Sesuaikan path import ini dengan lokasi file PopUpConfirmation kamu
import 'package:mino/widgets/popUp/pop_up_info.dart'; 

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodPage> {
  String? _selectedMood;

  final List<MoodItem> _moods = const [
    MoodItem(imagePath: 'assets/images/amazing.png', label: 'Amazing'),
    MoodItem(imagePath: 'assets/images/good.png', label: 'Good'),
    MoodItem(imagePath: 'assets/images/okey.png', label: 'Okey'),
    MoodItem(imagePath: 'assets/images/unusual.png', label: 'Unusual'),
    MoodItem(imagePath: 'assets/images/bad.png', label: 'Bad'),
  ];

  void _onNext() {
    if (_selectedMood == null) {
      // ── Tampilkan PopUpConfirmation ──
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return PopUpConfirmation(
            title: 'Mood Required',
            description: 'Please select your mood first\nbefore continuing.',
            isSingleButton: true,
            rightButtonText: 'OK',
            onRightTap: () => Navigator.pop(dialogContext),
            topIcon: Image.asset(
              'assets/images/mood_warning.png',
              height: 50,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.sentiment_satisfied_alt_rounded,
                color: Color(0xFFE8A838),
                size: 50,
              ),
            ),
          );
        },
      );
      return;
    }

    // Kirim event save ke bloc
    context.read<MoodJournalProvider>().setMood(_selectedMood!);

    // Pindah halaman ke JournalingPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JournalingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,
      body: Stack(
        children: [
          // Background utama
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          // Card pembungkus konten utama
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.88,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1E1611),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    // Top Bar
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
                                color: Color(0xFFE8A838),
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
                                'cancel',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 5),

                    // Pertanyaan utama
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'How is your mood\ntoday?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF3D59B),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.35,
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Grid Emojis
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

                    // Tombol Bawah
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: CustomButton(text: 'Next', onTap: _onNext),
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
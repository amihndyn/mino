import 'package:flutter/material.dart';
import 'package:mino/pages/home/home_page.dart';
import 'package:mino/pages/mood/widgets/journal_prompt_view.dart';
import 'package:mino/pages/mood/widgets/journal_writing_view.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/providers/moodjournal_provider.dart';

class JournalingPage extends StatefulWidget {
  const JournalingPage({super.key});

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  final TextEditingController _noteController = TextEditingController();
  bool _isWriting = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onSaveAndSkip() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()), 
      (route) => false, 
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membaca data mood dari Provider global
    final moodJournalProvider = context.watch<MoodJournalProvider>();
    
    // 1. Ambil nilai dasar dari provider (ubah ke lowercase agar pasti cocok)
    final String selectedMood = (moodJournalProvider.selectedMood ?? 'good').toLowerCase(); 
    
    // 2. 🔥 Path Gambar untuk 5 Mood (Folder Images)
    String mood = 'assets/images/good.png'; // Default
    if (selectedMood.contains('amazing')) {
      mood = 'assets/images/amazing.png';
    } else if (selectedMood.contains('okey')) {
      mood = 'assets/images/okey.png';
    } else if (selectedMood.contains('unusual')) {
      mood = 'assets/images/unusual.png';
    } else if (selectedMood.contains('bad')) {
      mood = 'assets/images/bad.png';
    }

    /// 3. Label Teks untuk 5 Mood (Dibikin huruf kecil semua agar estetikanya mirip)
    String moodLabel = 'good'; 
    if (selectedMood.contains('amazing')) {
      moodLabel = 'amazing';
    } else if (selectedMood.contains('okey')) {
      moodLabel = 'okey';
    } else if (selectedMood.contains('unusual')) {
      moodLabel = 'unusual';
    } else if (selectedMood.contains('bad')) {
      moodLabel = 'bad';
    }

    // 4. 🔥 Warna untuk 5 Mood (Silakan sesuaikan warnanya jika kurang pas)
    Color moodColor = AppColors.orange300; // Default Good
    if (selectedMood.contains('amazing')) {
      moodColor = Colors.green;        
    } else if (selectedMood.contains('okey')) {
      moodColor = Colors.orange;       
    } else if (selectedMood.contains('unusual')) {
      moodColor = Colors.blueGrey;     
    } else if (selectedMood.contains('bad')) {
      moodColor = Colors.red;          
    }

    return Scaffold(
      resizeToAvoidBottomInset: true, 
      body: Stack(
        children: [
          // ── 1. Background Utama Aplikasi ─────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // ── 2. Card Pembungkus Konten Utama ───────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.coklat900, 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // ── Top Bar (Today's Reflection & Cancel) ──────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Today's Reflection",
                              style: TextStyle(
                                color: AppColors.orange300, 
                                fontSize: 16,
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
                                  color: Colors.white60,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ── 3. Card Konten Inner (Prompt / Area Tulis) ────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _isWriting
                            ? JournalWritingView(
                                noteController: _noteController,
                                onClose: () => setState(() => _isWriting = false),
                                onSave: () {
                                  context.read<MoodJournalProvider>().setNote(_noteController.text);
                                  _onSaveAndSkip();
                                },
                              ) 
                            : JournalPromptView(
                                mood: mood,
                                moodLabel: moodLabel,
                                moodColor: moodColor, 
                                onNoteAdded: (result) {
                                  setState(() {
                                    _noteController.text = result;
                                    _isWriting = true;
                                  });
                                },
                              ), 
                      ), 
                    ),

                    const Spacer(flex: 2),

                    // ── 4. Tombol Bawah menggunakan CustomButton ──────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: CustomButton(
                          text: 'Skip and Save',
                          onTap: _onSaveAndSkip,
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
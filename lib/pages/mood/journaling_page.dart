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
    // Logika simpan atau lewatkan ke halaman HomeScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()), // Membuka HomePage baru
      (route) => false, // Menghapus semua riwayat halaman sebelumnya secara bersih
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membaca mood yang terpilih dari Provider global
    final moodJournalProvider = context.watch<MoodJournalProvider>();
    final selectedMood = moodJournalProvider.selectedMood;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Biar tidak tertutup keyboard saat ngetik
      body: Stack(
        children: [
          // ── 1. Background Utama Aplikasi (Diubah ke SVG) ─────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // ── 2. Card Pembungkus Konten Utama (Lebih Pendek) ───────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // Dibuat sekitar 80% layar agar background atas terlihat lebih banyak
              height: MediaQuery.of(context).size.height * 0.80,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.coklat900, // Warna cokelat gelap serasi
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
                                color: AppColors.orange300, // Gold soft
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
                                // FIX ERROR 1: Ubah menjadi fungsi tanpa parameter kosongan ()
                                onSave: () {
                                  // Ambil teks langsung dari _noteController
                                  context.read<MoodJournalProvider>().setNote(_noteController.text);
                                  _onSaveAndSkip();
                                },
                              ) // JournalWritingView
                            : JournalPromptView(
                                // FIX ERROR 2: Berikan parameter selectedMood yang diminta oleh widget
                                selectedMood: selectedMood, 
                                onNoteAdded: (result) {
                                  setState(() {
                                    _noteController.text = result;
                                    _isWriting = true;
                                  });
                                },
                              ), // JournalPromptView
                      ), // Container
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
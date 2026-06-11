import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:mino/core/data/model/request/reflection_request_model.dart';
import 'package:mino/core/presentation/home/bloc/reflection/reflection_bloc.dart'; 
import 'package:mino/pages/journal/note_detail_page.dart';
import 'package:mino/pages/mood/widgets/journal_prompt_view.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/providers/moodjournal_provider.dart';
import 'package:intl/intl.dart'; 

class JournalingPage extends StatefulWidget {
  const JournalingPage({super.key});

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  final TextEditingController _titleController = TextEditingController(); 
  final TextEditingController _noteController = TextEditingController();
  bool _isLoading = false; // 🔥 TETAP DIKEEP, JANGAN DIHAPUS!

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // 🔥 Logic Sausan: Konversi warna mood untuk dipakai di NoteDetailPage
  Color _getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'amazing': return const Color(0xFFE8A838);
      case 'good': return const Color(0xFF4CAF50);
      case 'okey': return const Color(0xFF2196F3);
      case 'unusual': return const Color(0xFF9C27B0);
      case 'bad': return const Color(0xFFE53935);
      default: return const Color(0xFFE8A838);
    }
  }

  // 🔥 Logic Sausan: Fungsi utama untuk save reflection ke backend
  void _onSaveAction({String? fallbackTitle, String? fallbackContent}) {
    // Jika sedang loading, kunci fungsi agar tidak bisa dispam klik
    if (_isLoading) return;

    final moodJournalProvider = context.read<MoodJournalProvider>();
    final selectedMood = moodJournalProvider.selectedMood ?? 'good';

    final String finalTitle = _titleController.text.isNotEmpty 
        ? _titleController.text 
        : (fallbackTitle ?? 'Daily Reflection');

    final String finalContent = _noteController.text.isNotEmpty 
        ? _noteController.text 
        : (fallbackContent ?? 'Saved mood tracking.');

    final request = ReflectionRequestModel(
      mood: selectedMood.toLowerCase(),
      title: finalTitle,
      content: finalContent,
    );

    context.read<ReflectionBloc>().add(ReflectionEvent.saveReflection(request));
  }

  @override
  Widget build(BuildContext context) {
    // Membaca data mood dari Provider global
    final moodJournalProvider = context.watch<MoodJournalProvider>();
    
    // 1. Ambil nilai dasar dari provider (ubah ke lowercase agar pasti cocok)
    final String selectedMood = (moodJournalProvider.selectedMood ?? 'good').toLowerCase(); 
    
    // 🔥 UI Ami: Path Gambar untuk 5 Mood (Folder Images)
    String moodAsset = 'assets/images/good.png'; 
    if (selectedMood.contains('amazing')) {
      moodAsset = 'assets/images/amazing.png';
    } else if (selectedMood.contains('okey')) {
      moodAsset = 'assets/images/okey.png';
    } else if (selectedMood.contains('unusual')) {
      moodAsset = 'assets/images/unusual.png';
    } else if (selectedMood.contains('bad')) {
      moodAsset = 'assets/images/bad.png';
    }

    // 🔥 UI Ami: Label Teks untuk 5 Mood (Dibikin huruf kecil semua agar estetikanya mirip)
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

    // 🔥 UI Ami: Warna untuk 5 Mood
    Color moodColor = AppColors.orange300; 
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
      // 🔥 Logic Sausan: Bungkus dengan BlocListener untuk menangani state
      body: BlocListener<ReflectionBloc, ReflectionState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () => setState(() => _isLoading = true),
            saveSuccess: (reflection) {
              // 🔒 Biarkan _isLoading tetap TRUE agar layar tetap nge-block putih/loading
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reflection successfully saved!')),
              );

              final String finalTitle = reflection.title ?? _titleController.text;
              final String finalContent = reflection.content ?? _noteController.text;
              final String finalMood = reflection.mood ?? selectedMood.toLowerCase();
              final String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteDetailPage(
                    noteTitle: finalTitle.isEmpty ? 'Daily Reflection' : finalTitle,
                    noteContent: finalContent.isEmpty ? 'Saved mood tracking.' : finalContent,
                    fullDate: formattedDate,
                    mood: 'assets/images/${finalMood.toLowerCase()}.png',
                    moodLabel: finalMood.toUpperCase(),
                    moodColor: _getMoodColor(finalMood),
                  ),
                ), 
                (route) => route.isFirst, 
              );
            },
            error: (message) {
              // Balikkan ke false HANYA ketika gagal/error agar user bisa mencoba lagi
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to save: $message'), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        child: Stack(
          children: [
            // ── 1. Background Utama Aplikasi (UI Ami) ─────────
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
                // 🔥 Jika sedang loading, ganti isi seluruh container menjadi sirkular loading tunggal
                child: _isLoading 
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.orange500,
                    ),
                  )
                : SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // Top Bar
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
                            // 🔥 UI Ami + Logic Sausan digabung di JournalPromptView
                            child: JournalPromptView(
                              mood: moodAsset,
                              moodLabel: moodLabel,
                              moodColor: moodColor,
                              onNoteAdded: (titleResult, contentResult) {
                                setState(() {
                                  _titleController.text = titleResult;
                                  _noteController.text = contentResult;
                                });
                                _onSaveAction(
                                  fallbackTitle: titleResult, 
                                  fallbackContent: contentResult
                                );
                              },
                            ), 
                          ),
                        ),

                        const Spacer(flex: 2),

                        // ── 4. Tombol Bawah "Skip and Save" ──────
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: CustomButton(
                              text: 'Skip and Save',
                              onTap: () => _onSaveAction(),
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
      ),
    );
  }
}
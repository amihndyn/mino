import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/button/custom_button.dart';

// ============================================
// NOTE EDIT PAGE (GABUNGAN DESAIN & LOGIC)
// ============================================

class NoteEditPage extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final String fullDate;
  final String mood;
  final String moodLabel;
  final Color moodColor;

  const NoteEditPage({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.fullDate,
    required this.mood,
    required this.moodLabel,
    required this.moodColor,
  });

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // Controllers untuk Edit
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  static const Color darkBrownBorder = Color(0xFF423125);
  static const double borderWidth = 2.0;

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi Controller dengan data awal
    _titleController = TextEditingController(text: widget.noteTitle);
    _contentController = TextEditingController(text: widget.noteContent);

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    // Jangan lupa dispose controller untuk mencegah memory leak
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🛠️ FIX: Mengunci warna dasar kanvas belakang menjadi gelap untuk mencegah kedipan putih saat keyboard muncul
      backgroundColor: AppColors.coklat900,
      // Ubah menjadi true agar saat keyboard muncul, layout bisa menyesuaikan (scrollable)
      resizeToAvoidBottomInset: true, 
      body: Stack(
        children: [
          // ── 1. Background Gambar Full Screen ─────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay
          Container(
            color: Colors.black.withValues(alpha: 0.3),
          ),

          // ── 2. Area Konten Utama dengan Animasi ─────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // APPBAR 
                CustomAppBar(
                  title: 'Edit Note',
                  // Menghilangkan tombol action edit karena sudah di page edit
                  actions: const [], 
                ),

                // Area Bawah Appbar yang Dianimasikan
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // ── 3. Info Mood, Judul (Editable), & Tanggal ───────────
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMoodChip(),
                                const SizedBox(height: 16),
                                
                                // 🔥 TEXTFIELD UNTUK JUDUL 🔥
                                TextField(
                                  controller: _titleController,
                                  style: TextStyle(
                                    color: widget.moodColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                    letterSpacing: 0.2,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter note title...',
                                    hintStyle: TextStyle(
                                      color: widget.moodColor.withValues(alpha: 0.5),
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                
                                const SizedBox(height: 6),
                                Text(
                                  widget.fullDate,
                                  style: const TextStyle(
                                    color: AppColors.coklat300,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // ── 4. Tumpukan Kertas (Konten Editable) ───────────
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.48,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Lapisan Kertas Belakang
                                  Transform.rotate(
                                    angle: -6 * (math.pi / 180),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      margin: const EdgeInsets.only(
                                          bottom: 12, right: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF2E2C9),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: darkBrownBorder,
                                          width: borderWidth,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Kertas Utama Paling Atas
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7EAD3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: darkBrownBorder,
                                        width: borderWidth,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.2),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.all(24),
                                        
                                        // 🔥 TEXTFIELD UNTUK KONTEN (MULTILINE) 🔥
                                        child: TextField(
                                          controller: _contentController,
                                          maxLines: null, // Agar bisa multi-line
                                          keyboardType: TextInputType.multiline,
                                          style: const TextStyle(
                                            color: Color(0xFF423125), // Warna tinta
                                            fontSize: 16,
                                            height: 1.6,
                                            letterSpacing: 0.1,
                                          ),
                                          decoration: const InputDecoration(
                                            hintText: 'Write your thoughts here...',
                                            hintStyle: TextStyle(
                                              color: Color(0x77423125),
                                            ),
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),

                          // ── 5. Tombol Bawah (Cancel & Save) ───────────────────
                          Center(
                            child: Container(
                              height: 80,
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.none,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Tombol Cancel
                                    SizedBox(
                                      height: 44,
                                      width: 140,
                                      child: CustomButton(
                                        text: 'Cancel',
                                        onTap: () => Navigator.pop(context),
                                      ),
                                    ),
                                    
                                    const SizedBox(width: 32),
                                    
                                    // Tombol Save
                                    SizedBox(
                                      height: 44,
                                      width: 140,
                                      child: CustomButton(
                                        text: 'Save',
                                        onTap: () {
                                          // Implementasi logika Save ke API / Database lokal
                                          final updatedTitle = _titleController.text;
                                          final updatedContent = _contentController.text;
                                          
                                          print("Judul Baru: $updatedTitle");
                                          print("Konten Baru: $updatedContent");
                                          
                                          // Navigator.pop(context, true); 
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.coklat900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: widget.moodColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            widget.mood, 
            height: 28,  
            width: 28,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.sentiment_satisfied_alt,
                color: widget.moodColor,
                size: 28,
              );
            },
          ),
          
          const SizedBox(width: 8),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mood',
                style: TextStyle(
                  color: AppColors.coklat300,
                  fontSize: 10,
                ),
              ),
              Text(
                widget.moodLabel,
                style: TextStyle(
                  color: widget.moodColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
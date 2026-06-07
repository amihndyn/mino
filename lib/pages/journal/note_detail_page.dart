import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/button/custom_button.dart';

// ============================================
// NOTE DETAIL PAGE (GABUNGAN DESAIN & LOGIC)
// ============================================

class NoteDetailPage extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final String fullDate;
  final String mood;
  final String moodLabel;
  final Color moodColor;

  const NoteDetailPage({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.fullDate,
    required this.mood,
    required this.moodLabel,
    required this.moodColor,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  static const Color darkBrownBorder = Color(0xFF423125);
  static const double borderWidth = 2.0;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                // APPBAR (Tetap ada untuk fungsi Edit)
                CustomAppBar(
                  title: 'Notes',
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

                          // ── 3. Baris Info: Judul & Tanggal (Kiri) | Mood (Kanan) ───────────
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ── SEBELAH KIRI: Kumpulan Judul dan Tanggal ──
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.noteTitle,
                                        style: TextStyle(
                                          color: widget.moodColor,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        widget.fullDate,
                                        style: const TextStyle(
                                          color: AppColors.coklat300,
                                          fontSize: 14,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(width: 16),

                                // ── SEBELAH KANAN: Chip Mood ──
                                _buildMoodChip(),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40), 

                          // ── 4. Tumpukan Kertas (Isi Note) ───────────
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

                                  // Kertas Utama Paling Atas (Menampilkan Isi Konten)
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange200,
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: widget.noteContent
                                              .split('\n\n')
                                              .map(
                                                (para) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 18),
                                                  child: Text(
                                                    para.trim(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF423125),
                                                      fontSize: 16,
                                                      height: 1.15,
                                                      letterSpacing: 1,
                                                      fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 90,), 
                          
                          // ── 5. Custom Button Area ───────────
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 44),
                            child: CustomButton(
                              text: 'Edit Note',
                              onTap: () { // 🔥 Sekarang sudah menggunakan onTap
                                // Aksi edit note ditaruh di sini
                              },
                            ),
                          ),
                                           
                          const SizedBox(height: 24), 
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
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
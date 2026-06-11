import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:mino/pages/home/home_page.dart'; 
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class WriteJournalScreen extends StatefulWidget {
  final String mood;
  final String moodLabel;
  final Color moodColor;

  const WriteJournalScreen({
    super.key,
    required this.mood,
    required this.moodLabel,
    required this.moodColor,
  });

  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
  static const Color darkBrownBorder = Color(0xFF423125);
  static const double borderWidth = 2.0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  bool _isButtonsRowVisible = false;
  late String _currentDate; 

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateInputs);
    _contentController.addListener(_validateInputs);
    
    // Format sesuai gambar: "Sunday, 26 May 2026"
    _currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
  }

  void _validateInputs() {
    final bool hasTitle = _titleController.text.trim().isNotEmpty;
    final bool hasContent = _contentController.text.trim().isNotEmpty;

    setState(() {
      _isButtonsRowVisible = hasTitle && hasContent;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _handleSave() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── Background Gambar Full Screen ─────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // Area Konten Utama
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                
                // ── Header: Judul + Tanggal (Kiri) & Chip Mood (Kanan) ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sisi Kiri: Blok teks Judul & Tanggal dibawahnya
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _titleController,
                              focusNode: _titleFocusNode,
                              autofocus: true,
                              cursorColor: const Color(0xFFE8C37C),
                              cursorWidth: 1.5,
                              style: const TextStyle(
                                color: Color(0xFFE8C37C), // Warna krem emas sesuai gambar
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Enter topic',
                                hintStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Tanggal berada tepat di bawah Judul
                            Text(
                              _currentDate,
                              style: const TextStyle(
                                color: Colors.white54, // Abu-abu semi transparan
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 12),

                      // Sisi Kanan: Chip Mood Kapsul (Sesuai image_564562.png)
                      _buildMoodChip(),
                    ],
                  ),
                ),

                const Spacer(),

                // ── Tumpukan Kertas (Input Isi Jurnal) ───────────────────
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88, 
                    height: MediaQuery.of(context).size.height * 0.52, 
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: -4 * (math.pi / 180), 
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12, right: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2E2C9),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: darkBrownBorder, width: borderWidth),
                            ),
                          ),
                        ),
                        
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7EAD3), 
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: darkBrownBorder, width: borderWidth),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _contentController,
                            focusNode: _contentFocusNode,
                            cursorColor: const Color(0xFF423125),
                            cursorWidth: 2.0,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: const TextStyle(
                              color: Color(0xFF423125),
                              fontSize: 16,
                              height: 1.5,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Write down your thoughts here...',
                              hintStyle: TextStyle(
                                color: Colors.black26, 
                                fontSize: 16,
                              ),
                              contentPadding: EdgeInsets.all(24),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // ── Logika Tombol Bawah ──────
                Center(
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: _isButtonsRowVisible
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,

                    firstChild: Container(
                      height: 80, 
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.none,
                        child: SizedBox(
                          height: 44,
                          width: 140,
                          child: CustomButton(
                            text: 'Cancel',
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),

                    secondChild: Container(
                      height: 80, 
                      alignment: Alignment.center,
                      child: FittedBox( 
                        fit: BoxFit.none,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 44,
                              width: 140,
                              child: CustomButton(
                                text: 'Cancel',
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                            const SizedBox(width: 32),
                            SizedBox(
                              height: 44,
                              width: 140,
                              child: CustomButton(
                                text: 'Save',
                                onTap: _handleSave,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 CHIP MOOD KAPSUL DENGAN BORDER EMAS STATIS (TIDAK BERUBAH WARNA)
  Widget _buildMoodChip() {
    // Memastikan teks berawalan huruf kapital (misal: "Amazing")
    String formattedLabel = widget.moodLabel.isNotEmpty 
        ? widget.moodLabel[0].toUpperCase() + widget.moodLabel.substring(1)
        : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25), // Latar gelap transparan solid
        borderRadius: BorderRadius.circular(30), // Bentuk kapsul lonjong
        border: Border.all(
          color: const Color(0xFF7A5C3E).withOpacity(0.6), // Border tipis warna coklat emas statis
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.mood,
            height: 32,  
            width: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Mood',
                style: TextStyle(
                  color: Colors.white38, // Label "Mood" kecil di atas
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                formattedLabel,
                style: const TextStyle(
                  color: Color(0xFFE8C37C), // Teks nama mood warna emas statis
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
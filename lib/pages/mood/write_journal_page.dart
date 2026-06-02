import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/pages/home/home_page.dart'; 
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({super.key});

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

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateInputs);
    _contentController.addListener(_validateInputs);
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
          // ── 1. Background Gambar Full Screen (Diubah ke SVG) ─────────
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
                const SizedBox(height: 20),
                
                // ── 3. Input Judul / Topic (Kursor Aktif Otomatis) ───────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: TextField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    autofocus: true,
                    cursorColor: AppColors.coklat100,
                    cursorWidth: 1.5,
                    cursorRadius: const Radius.circular(2),
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: AppColors.coklat100,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter topic',
                      hintStyle: TextStyle(
                        color: AppColors.coklat100,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      // ── Ubah di bagian ini ──
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        top: 2,
                        bottom: 4,
                      ),
                    ),
                  ),
                ),

                // ── 3. Komponen Kertas Numpuk (Menggunakan Widget Baru) ───────

                const Spacer(),

                // ── 4. Logika Tombol Bawah (Cancel / Save) ───────────────────
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
                            margin: const EdgeInsets.only(bottom: 12, right: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2E2C9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: darkBrownBorder, width: borderWidth),
                            ),
                          ),
                        ),
                        
                        // Kertas Utama Paling Atas (Input Isi Jurnal)
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7EAD3), 
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: darkBrownBorder, width: borderWidth),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _contentController,
                            focusNode: _contentFocusNode,
                            cursorColor: const Color(0xFF423125), // Kursor warna cokelat tua saat mengetik di kertas jurnal
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
                              hintText: 'Enter topic',
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

                // ── 5. Logika Tombol Bawah Menggunakan Cukup Ukuran Saja ──────
                Center(
                  child: SizedBox(
                    height: 40, // Memberikan ruang cukup agar bayangan tombol tidak terpotong
                    child: Center(
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 200),
                        crossFadeState: _isButtonsRowVisible
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,

                        // Kondisi Kosong: Tombol Tunggal (Cancel)
                        firstChild: SizedBox(
                          height: 100,
                          width: 150,
                          child: CustomButton(
                            text: 'Cancel',
                            onTap: () => Navigator.pop(context),
                          ),
                        ),

                        // Kondisi Terisi: Tombol Cancel & Save Berdampingan
                        secondChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: CustomButton(
                                text: 'Cancel',
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 150,
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
}

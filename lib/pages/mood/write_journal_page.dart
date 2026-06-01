import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/pages/home/home_page.dart';
import 'package:mino/pages/mood/widgets/journal_paper_stack.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({super.key});

  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
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
          // ── 1. Background Gambar Full Screen ─────────────────────────
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Area Konten Utama
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),

                // ── 2. Input Judul / Topic ───────────────────────────────────
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

                const Spacer(),

                // ── 3. Komponen Kertas Numpuk (Menggunakan Widget Baru) ───────
                Center(
                  child: JournalPaperStack(
                    controller: _contentController,
                    focusNode: _contentFocusNode,
                    onChanged: (value) => _validateInputs(),
                  ),
                ),

                const Spacer(),

                // ── 4. Logika Tombol Bawah (Cancel / Save) ───────────────────
                Center(
                  child: SizedBox(
                    height:
                        50, // Dinaikkan sedikit jadi 50 agar bayangan CustomButton aman
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

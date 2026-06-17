import 'dart:math' as math;
import 'package:flutter/material.dart';
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

  // 🔥 Langsung simpan dan tutup halaman tanpa popup
  void _handleSave() {
    final Map<String, String> journalData = {
      "title": _titleController.text.trim(),
      "content": _contentController.text.trim(),
    };
    
    // Kembalikan map data ke layar sebelumnya
    Navigator.pop(context, journalData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Input Judul
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
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        top: 2,
                        bottom: 4,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Kertas Input Isi Jurnal
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: -6 * (math.pi / 180),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12, right: 8),
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
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7EAD3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: darkBrownBorder,
                              width: borderWidth,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
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
                              hintText: 'Write your thoughts here...',
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

                // Animasi Tombol Bawah
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
}
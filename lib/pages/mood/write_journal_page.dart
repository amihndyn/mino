import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/pages/home/home_page.dart'; 
import 'package:mino/widgets/button/custom_button.dart';

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
    const Color darkBrownBorder = Color(0xFF2A1A0E);
    const double borderWidth = 1.8;

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
                const SizedBox(height: 20),
                

                // ── 3. Input Judul / Topic (Kursor Aktif Otomatis) ───────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: TextField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    autofocus: true, // 1. MEMBUAT KURSOR KEDAP-KEDIP OTOMATIS SAAT BUKA HALAMAN
                    cursorColor: const Color(0xFFE6D5C3), // 2. KUSTOMISASI WARNA GARIS KEDAP-KEDIP
                    cursorWidth: 2.5, // Mengatur ketebalan garis kursor agar lebih terlihat
                    cursorRadius: const Radius.circular(2), // Membuat ujung kursor sedikit tumpul bulat
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Color(0xFFE6D5C3), 
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter topic',
                      hintStyle: TextStyle(
                        color: Color(0xFF9A8675), 
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

                const Spacer(),

                // ── 4. Komponen Kertas Numpuk + Border Cokelat ───────────────
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
                          width: 150,
                          // height: 50, <── Dihapus agar bayangan (glow) bisa melebar sempurna
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
                              // height: 50, <── Dihapus agar bayangan (glow) bisa melebar sempurna
                              child: CustomButton(
                                text: 'Cancel',
                                onTap: () => Navigator.pop(context), 
                              ),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 150,
                              // height: 50, <── Dihapus agar bayangan (glow) bisa melebar sempurna
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
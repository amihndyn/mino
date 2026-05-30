import 'package:flutter/material.dart';
import 'package:mino/pages/mood/widgets/journal_paper_stack.dart';
 // Mengimport komponen kertas di atas

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({super.key});

  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
  final TextEditingController _topicController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  // ignore: unused_field
  String? _selectedMood;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _selectedMood = args;
    }
  }

  @override
  void initState() {
    super.initState();
    // Auto-focus keyboard saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _topicController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSave() {
    final text = _topicController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tulis sesuatu dulu ya ✍️'),
          backgroundColor: Color(0xFF3D2B1F),
        ),
      );
      return;
    }
    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Backdrop
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.55)),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Title Header ─────────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Enter topic',
                        style: TextStyle(
                          color: Color(0xFFE8A838),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (_topicController.text.isNotEmpty)
                        GestureDetector(
                          onTap: _onSave,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── Area Tulis Menggunakan Eksternal Widget ──────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: JournalPaperStack(
                      controller: _topicController,
                      focusNode: _focusNode,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ),

                // ── Tombol Cancel ────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A1A0E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.white24, width: 1),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
}
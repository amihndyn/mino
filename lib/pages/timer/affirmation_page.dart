import 'package:flutter/material.dart';

class AffirmationPage extends StatefulWidget {
  // ── 1. Daftarkan parameter callback di sini ──
  final VoidCallback onBack;

  const AffirmationPage({super.key, required this.onBack});

  @override
  State<AffirmationPage> createState() => _AffirmationPageState();
}

class _AffirmationPageState extends State<AffirmationPage> {
  int _currentImageIndex = 0;

  final List<String> _images = [
    'assets/images/wallpaper.png', 
    'assets/images/wallpaperr.png',
  ];

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Menggunakan Scaffold agar manajemen layar mandiri aman
      body: Stack(
        children: [
          // LAYER 1: Wallpaper Utama (Full Screen & Bisa di-tap ganti gambar)
          GestureDetector(
            onTap: _nextImage,
            child: SizedBox.expand( 
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800), 
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image.asset(
                  _images[_currentImageIndex],
                  key: ValueKey<int>(_currentImageIndex), 
                  fit: BoxFit.cover, 
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),

          // LAYER 2: Tombol Back Callback Melayang di Pojok Kiri Atas
          SafeArea(
            child: Positioned(
              top: 16,
              left: 16,
              child: CircleAvatar(
                // Lingkaran transparan hitam tipis agar tombol tetap kelihatan di wallpaper terang/gelap
                backgroundColor: Colors.black.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  onPressed: widget.onBack, // 🔥 Memicu fungsi kembali ke halaman timer utama
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
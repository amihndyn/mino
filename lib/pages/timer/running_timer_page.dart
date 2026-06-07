import 'dart:async';
import 'dart:math'; // Dibutuhkan untuk fungsi sin() pada animasi
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/pages/timer/finish_timer_page.dart';
import 'package:mino/widgets/button/custom_button.dart';

class RunningTimerPage extends StatefulWidget {
  final int minutes; // Menerima durasi timer dari halaman sebelumnya

  const RunningTimerPage({super.key, required this.minutes});

  @override
  State<RunningTimerPage> createState() => _RunningTimerPageState();
}

// Tambahkan SingleTickerProviderStateMixin untuk animasi
class _RunningTimerPageState extends State<RunningTimerPage> with SingleTickerProviderStateMixin {
  Timer? _timer;
  late int _totalSeconds;
  late int _remainingSeconds;

  // Controller untuk animasi glow di belakang timer
  late final AnimationController _glowController;

  // ── DAFTAR GAMBAR YANG AKAN DITAMPILKAN BERGANTIAN ──
  final List<String> _imagePaths = [
    'assets/images/satu.svg',
    'assets/images/dua.svg',
    'assets/images/tiga.svg',
    'assets/images/empat.svg',
    'assets/images/lima.svg',
    'assets/images/enam.svg',
  ];

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.minutes * 60;
    _remainingSeconds = _totalSeconds;
    
    // Inisialisasi animasi glow (berulang setiap 2 detik)
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        // JIKA WAKTU HABIS (0 DETIK)
        _timer?.cancel(); 
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FinishTimerPage(
              completedMinutes: widget.minutes,
            ),
          ),
        );
      }
    });
  }

  // ── FUNGSI CETAKAN LINGKARAN GLOW ──
  Widget _buildGlowCircle() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE8A838).withOpacity(0.5), // Warna cahaya
            blurRadius: 40,
            spreadRadius: 15, // Seberapa besar cahayanya menyebar
          ),
        ],
      ),
    );
  }

  // ── FUNGSI UNTUK MEMUNCULKAN POP UP KONFIRMASI ──
  Future<void> _showExitConfirmationDialog() async {
    _timer?.cancel();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF423125),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE8A838).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mengubah ikon berlian menjadi SVG dengan fallback Icon
                SvgPicture.asset(
                  'assets/images/diamond.svg', 
                  height: 60,
                  width: 60,
                  placeholderBuilder: (context) => const Icon(
                    Icons.diamond, 
                    color: Colors.blue, 
                    size: 60,
                  ),
                ),
                
                const SizedBox(height: 20),

                const Text(
                  'Leave Focus Session?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),

                const Text(
                  'If you leave now, 3 diamonds will\nbe deducted.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: const Text(
                        'Back to home',
                        style: TextStyle(
                          color: Color(0xFFE8A838),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 140, 
                      height: 44,
                      child: CustomButton(
                        text: 'Next',
                        onTap: () {
                          Navigator.pop(dialogContext);
                          _startTimer();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _glowController.dispose(); // Jangan lupa membuang controller animasi
    super.dispose();
  }

  // Fungsi format waktu (MM.SS)
  String get _formattedTime {
    int m = _remainingSeconds ~/ 60;
    int s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}.${s.toString().padLeft(2, '0')}';
  }

  // ── LOGIKA GANTI GAMBAR PROPORSIONAL ──
  Widget _buildDynamicImage() {
    int elapsedSeconds = _totalSeconds - _remainingSeconds;
    
    double interval = _totalSeconds / _imagePaths.length;
    if (interval <= 0) interval = 1;

    int imageIndex = elapsedSeconds ~/ interval;

    if (imageIndex >= _imagePaths.length) {
      imageIndex = _imagePaths.length - 1;
    }

    String currentImage = _imagePaths[imageIndex];
    
    // 🔥 UKURAN GAMBAR DIPERBESAR MENJADI 350
    double imageSize = 350; 

    if (currentImage.endsWith('.svg')) {
      return SvgPicture.asset(
        currentImage,
        height: imageSize,
      );
    } else {
      return Image.asset(
        currentImage,
        height: imageSize,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF140C08), // Warna dasar default
      body: Stack(
        children: [
          // ── Background Utama (Diubah ke SVG) ───────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),
          
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // ── 1. Teks Timer dengan 2 Glow yang Mengorbit (Muter) ──
                AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, child) {
                    // Nilai putaran dari 0.0 sampai 2*Pi (satu putaran penuh)
                    final double theta = _glowController.value * 2 * pi;

                    // Jarak seberapa jauh lingkaran bergerak (X = kiri-kanan, Y = atas-bawah)
                    final double radiusX = 80.0; // Lebar putaran
                    final double radiusY = 20.0; // Tinggi putaran (biar ada efek muter melingkar)

                    // 📍 Posisi Lingkaran 1
                    final double x1 = sin(theta) * radiusX;
                    final double y1 = cos(theta) * radiusY;

                    // 📍 Posisi Lingkaran 2 (Lawan arahnya, ditambah Pi)
                    final double x2 = sin(theta + pi) * radiusX;
                    final double y2 = cos(theta + pi) * radiusY;

                    return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none, // Supaya glow tidak terpotong
                      children: [
                        // --- Lingkaran Glow 1 ---
                        Transform.translate(
                          offset: Offset(x1, y1),
                          child: _buildGlowCircle(),
                        ),

                        // --- Lingkaran Glow 2 ---
                        Transform.translate(
                          offset: Offset(x2, y2),
                          child: _buildGlowCircle(),
                        ),

                        // --- Angka Timer ---
                        Text(
                          _formattedTime,
                          style: const TextStyle(
                            color: Color(0xFFF7EAD3), // Warna krem
                            fontSize: 68,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                
                const SizedBox(height: 60),

                // ── 2. Gambar (Ukuran sudah diperbesar) ──
                _buildDynamicImage(),

                const Spacer(),

                // ── 3. Tombol Back to home ──
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    onTap: () {
                      _showExitConfirmationDialog();
                    },
                    child: const Text(
                      'Back to home',
                      style: TextStyle(
                        color: Color(0xFFE8A838),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
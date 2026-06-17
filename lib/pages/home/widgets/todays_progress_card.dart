import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class TodaysProgressCard extends StatelessWidget {
  // ── DATA PROGRESS RIIL DARI BLOC / PROVIDER ──
  final int completedHabits;
  final int totalHabits;
  final int completedChallenges;
  final int totalChallenges;

  const TodaysProgressCard({
    super.key,
    required this.completedHabits,
    required this.totalHabits,
    required this.completedChallenges,
    required this.totalChallenges,
  });

  @override
  Widget build(BuildContext context) {
    // ── KALKULASI PERSENTASE GABUNGAN OTOMATIS ──
    final int totalTasks = totalHabits + totalChallenges;
    final int completedTasks = completedHabits + completedChallenges;
    
    // Diproteksi clamp(0, 100) agar angka persentase tidak minus atau lebih dari 100%
    final int percentage = totalTasks == 0 
        ? 0 
        : ((completedTasks / totalTasks) * 100).round().clamp(0, 100);

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      // 1. KONTAINER LUAR: Stroke/Border dengan Linear Gradient
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFEEAB63), 
            Color(0xFFFFE7C3), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE6A84A),
            blurRadius: 12,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(1), 
        padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 25),
        width: double.infinity,
        // 2. KONTAINER DALAM: Warna latar utama maskot widget
        decoration: BoxDecoration(
          color: AppColors.coklat800, 
          borderRadius: BorderRadius.circular(11), 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- HEADER SECTION ---
            const Text(
              "Today’s Progress",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Keep going, you’re doing great!",
              style: TextStyle(
                color: AppColors.orange300, 
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 19),

            // --- PROGRESS SECTION ---
            Row(
              children: [
                // 1. Persentase Lingkaran (Kiri)
                SizedBox(
                  width: 85,
                  height: 85,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Lingkaran Progress dengan CustomPainter
                      SizedBox(
                        width: 85,
                        height: 85,
                        child: CustomPaint(
                          painter: _CircularProgressPainter(
                            percentage: percentage.toDouble(),
                          ),
                        ),
                      ),
                      
                      // Teks Persentase di Tengah Lingkaran
                      Text(
                        "$percentage%", 
                        style: const TextStyle(
                          color: Color(0xFFE6A84A),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 23),

                // 2. Detail Rincian Tugas (Kanan)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rincian Habit Completed
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset(
                              "assets/icons/centang.png", 
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 23),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$completedHabits/$totalHabits", // 🟢 Jumlah habit riil & dinamis
                                  style: const TextStyle(
                                    color: AppColors.orange300,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  "Habit completed",
                                  style: TextStyle(
                                    color: AppColors.orange100,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),

                      // Rincian Challenge Completed
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset(
                              "assets/icons/flag.png", 
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 23),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$completedChallenges/$totalChallenges", // 🟢 Jumlah challenge riil & dinamis
                                  style: const TextStyle(
                                    color: AppColors.orange300,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  "Challenge completed",
                                  style: TextStyle(
                                    color: AppColors.orange100,
                                    fontSize: 12,
                                    letterSpacing: 1
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;

  _CircularProgressPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Setting warna track lingkaran kosong (Gelap transparan)
    Paint backgroundPaint = Paint()
      ..color = const Color(0xFFE6A84A).withOpacity(0.15) 
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;

    // 2. Setting warna isi progress bar (Warna Emas Jingga)
    Paint progressPaint = Paint()
      ..color = AppColors.orange300
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; 

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - 4; 

    // Gambar lingkaran dasar
    canvas.drawCircle(center, radius, backgroundPaint);

    // Hitung lengkungan radial sudut berdasarkan persen tugas
    double startAngle = -math.pi / 2; // Dimulai tepat dari jam 12 atas
    double sweepAngle = 2 * math.pi * (percentage / 100).clamp(0.0, 1.0);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
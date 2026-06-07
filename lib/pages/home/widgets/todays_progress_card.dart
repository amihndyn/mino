import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class TodaysProgressCard extends StatelessWidget {
  const TodaysProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      // 1. KONTAINER LUAR: Berfungsi sebagai Stroke/Border dengan Linear Gradient
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFEEAB63), // Warna awal stroke
            Color(0xFFFFE7C3), // Warna akhir stroke
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
        // Margin 1 tebalnya sama dengan stroke width: 1
        margin: const EdgeInsets.all(1), 
        padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 25),
        width: double.infinity,
        // 2. KONTAINER DALAM: Warna utama widget
        decoration: BoxDecoration(
          color: AppColors.coklat800, // Menggunakan kode 8-digit yang valid
          borderRadius: BorderRadius.circular(11), // Dikurangi 1 agar melengkung sempurna mengikuti kontainer luar
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
                color: AppColors.orange300, // Disesuaikan sedikit agar senada dengan stroke baru
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
                Container(
                  margin: const EdgeInsets.only(right: 23),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/tk18z1w9_expires_30_days.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Text(
                    "84%",
                    style: TextStyle(
                      color: Color(0xFFE6A84A),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // 2. Detail Progress (Kanan)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Habit Completed
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset(
                              "assets/icons/centang.png", // <-- Diubah ke Local Asset
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 23),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1/3",
                                  style: TextStyle(
                                    color: AppColors.orange300,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
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

                      // Challenge Completed
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset(
                              "assets/icons/flag.png", // <-- Diubah ke Local Asset
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 23),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1/2",
                                  style: TextStyle(
                                    color: AppColors.orange300,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
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
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class TodaysProgressCard extends StatelessWidget {
  // 🔥 1. Terima parameter data progress riil dari Bloc/Laravel
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
    // 🔥 2. Hitung persentase total secara matematis & otomatis
    final int totalTasks = totalHabits + totalChallenges;
    final int completedTasks = completedHabits + completedChallenges;
    final int percentage = totalTasks == 0 ? 0 : ((completedTasks / totalTasks) * 100).round();

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
        // 2. KONTAINER DALAM: Warna utama widget
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
                // 1. Persentase Lingkaran (Kiri) - Dioptimalkan agar Teks Dinamis Seimbang
                Container(
                  margin: const EdgeInsets.only(right: 23),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/6xlrx1RpIF/tk18z1w9_expires_30_days.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(
                    "$percentage%", // 🔥 3. Nilai persentase dinamis hasil kalkulasi database
                    style: const TextStyle(
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
                              "assets/icons/centang.png", 
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 23),
                          // 🔥 4. HAPUS kata 'const' di depan Column agar anak-anaknya bisa menerima data dinamis
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$completedHabits/$totalHabits", // 🔥 5. Rasio habit dinamis
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

                      // Challenge Completed
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
                          // 🔥 6. HAPUS kata 'const' di depan Column ini juga
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$completedChallenges/$totalChallenges", // 🔥 7. Rasio challenge dinamis
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
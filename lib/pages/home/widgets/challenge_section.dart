import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 🔥 Import Bloc
import 'package:mino/core/constants/app_colors.dart';
// Ambil patch bloc & model kamu, sesuaikan path import ini jika letaknya berbeda:
// import 'package:mino/bloc/dashboard/dashboard_bloc.dart';
import 'challenge_progress_card.dart';

class ChallengeSection extends StatelessWidget {
  // 🔥 1. Terima parameter data list challenges hasil lemparan dari HomePage / DashboardBloc
  final List<dynamic> challenges;

  const ChallengeSection({
    super.key,
    required this.challenges, // Wajib diisi dari luar
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Challenge",
          style: TextStyle(
            color: AppColors.orange300,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 16),

        // 🔥 2. Cek jika data challenges kosong dari API Laravel
        if (challenges.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "No challenges available today.",
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ),

        // 🔥 3. Loop data secara dinamis menggunakan perulangan Iterable map (.toList())
        ...challenges.map((item) {
          // Asumsi field dari JSON Laravel: item.title, item.current, item.total, item.is_completed, item.image
          // Sesuaikan nama field di bawah ini dengan respon database API Laravel kamu ya!
          final String title = item.title;
          final int current = item.currentProgress;
          final int total = item.totalProgress;
          final bool checked = item.isCompleted;
          final String? image = item.imageAsset;

          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ), // Jarak antar kartu tantangan
            child: ChallengeProgressCard(
              title: title,
              imageAsset:
                  image ??
                  'assets/images/note2.png', // Fallback asset jika null
              currentProgress: current,
              totalProgress: total,
              isChecked: checked, // 🔥 SINKRON: Mengisi parameter wajib baru
              onToggle: () {
                // 🔥 4. AKSI TAP: Kirim Event ke Bloc untuk menembak API Laravel
                // context.read<DashboardBloc>().add(ToggleChallengeEvent(challengeId: item['id']));

                // Info log sementara untuk testing klik
                print("Tantangan '${title}' di-klik!");
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}

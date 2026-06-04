import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/models/progress_model.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      StatData(label: 'Habits Completed', value: '128', icon: Icons.track_changes_rounded),
      StatData(label: 'Focus Hours', value: '42h', icon: Icons.emoji_events_rounded),
      StatData(label: 'Challenge completed', value: '21 Days', icon: Icons.diamond_rounded),
      StatData(label: 'Diamonds Earned', value: '16', icon: Icons.diamond_rounded),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.35, // Disesuaikan agar tinggi kartu pas dengan teks 2 baris
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(StatData stat) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.coklat900.withValues(alpha: 0.65), // Background gelap transparan
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.coklat600.withValues(alpha: 0.25), // Border tipis luar
          width: 1,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none, // Mengizinkan komponen sedikit keluar/mepet jika diperlukan
        children: [
          // IKON BACKGROUND (Pojok Kanan Atas)
          Positioned(
            top: -4,
            right: -4,
            child: Icon(
              stat.icon,
              // Menggunakan opacity rendah (sekitar 15-20%) agar terlihat sebagai watermark semata
              color: AppColors.orange400.withValues(alpha: 0.18),
              size: 46, 
            ),
          ),
          
          // KONTEN TEKS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menggunakan FractionallySizedBox agar teks tidak menabrak ikon di kanan
              FractionallySizedBox(
                widthFactor: 0.85,
                child: Text(
                  stat.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.coklat300.withValues(alpha: 0.75),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                stat.value,
                style: TextStyle(
                  color: AppColors.orange400, // Warna emas/oranye Mino
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
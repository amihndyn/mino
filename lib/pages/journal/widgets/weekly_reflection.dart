import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/journal/note_list_page.dart';
import 'package:mino/widgets/button/custom_button.dart';

class WeeklyReflection extends StatelessWidget {
  const WeeklyReflection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.orange700.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // JUDUL UTAMA
              const Text(
                'Weekly Reflection',
                style: TextStyle(
                  color: Color(0xFFFFF1E6),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 14),
              
              // DESKRIPSI REFLEKSI
              Text(
                'This week, you stayed consistent and made meaningful progress toward your goals.',
                style: TextStyle(
                  color: AppColors.coklat300.withValues(alpha: 0.85),
                  fontSize: 15,
                  height: 1.45,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 26),
              
              // TOMBOL ACTION MENGGUNAKAN CUSTOMBUTTON TEMPLATE
              CustomButton(
                text: 'View full reflection',
                onTap: () {
                  final now = DateTime.now();
                  final oneWeekAgo = now.subtract(const Duration(days: 7));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteListPage(
                        // Kirim parameter tanggal ke NoteListPage
                        startDate: oneWeekAgo,
                        endDate: now,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
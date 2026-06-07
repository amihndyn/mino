import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/journal/note_list_page.dart';
import 'package:mino/widgets/button/custom_button.dart';

class MonthlyReflection extends StatelessWidget {
  final String? selectedMonth;

  const MonthlyReflection({
    super.key,
    this.selectedMonth,
  });

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
                'Monthly Reflection',
                style: TextStyle(
                  color: Color(0xFFFFF1E6),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 14),
              
              // DESKRIPSI REFLEKSI BULANAN
              Text(
                'A look back at your journey this month. See how far you\'ve come and what you can improve.',
                style: TextStyle(
                  color: AppColors.coklat300.withValues(alpha: 0.85),
                  fontSize: 15,
                  height: 1.45,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 26),
              
              // TOMBOL ACTION
              CustomButton(
                text: 'View full reflection',
                onTap: () {
                  // LOGIKA BULANAN: Ambil rentang 30 hari ke belakang
                  final now = DateTime.now();
                  final thirtyDaysAgo = now.subtract(const Duration(days: 30));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteListPage(
                        startDate: thirtyDaysAgo,
                        endDate: now,
                        pageTitle: 'Monthly Notes', // Kirim judul khusus
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
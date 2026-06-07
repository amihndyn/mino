import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class MonthPickerSheet extends StatelessWidget {
  final String selectedMonth;
  final List<String> months;
  final Function(String) onSelected;

  const MonthPickerSheet({
    super.key,
    required this.selectedMonth,
    required this.months,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.coklat900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.orange700.withAlpha((0.4 * 255).toInt())),
        
        // --- EFEK GLOW KOTAK UTAMA (LUAR) ---
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withAlpha((0.25 * 255).toInt()), 
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
        // ------------------------------------
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.coklat600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Pilih Bulan',
            style: TextStyle(
              color: AppColors.orange100,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, 
              childAspectRatio: 1.8, 
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: months.length,
            itemBuilder: (_, i) {
              final month = months[i];
              final isSel = month == selectedMonth;
              return GestureDetector(
                onTap: () => onSelected(month),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isSel ? AppColors.orange800 : AppColors.coklat800,
                    borderRadius: BorderRadius.circular(50),
                    
                    // --- EFEK GLOW TOMBOL BULAN ---
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withAlpha((0.25 * 255).toInt()), 
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    // ------------------------------
                    
                    border: Border.all(
                      color: isSel ? AppColors.orange400 : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    month.split(' ')[0],
                    style: TextStyle(
                      color: isSel ? AppColors.orange100 : Colors.white70, 
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
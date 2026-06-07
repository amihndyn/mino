import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/widgets/button/custom_button.dart'; // Pastikan path ini benar sesuai strukturmu

class DeleteHabitDialog extends StatefulWidget {
  const DeleteHabitDialog({super.key});

  @override
  State<DeleteHabitDialog> createState() => _DeleteHabitDialogState();
}

class _DeleteHabitDialogState extends State<DeleteHabitDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Inisialisasi Animation Controller (durasi muncul 400 milidetik)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Animasi muncul dari bawah (Y: 1.0) ke posisi normal (Y: 0.0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), 
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuart, // Efek melambat di akhir
    ));

    // Jalankan animasi saat dialog pertama kali di-*build*
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Dialog(
        backgroundColor: const Color(0xFF4C3D33), // Cokelat gelap
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          // BORDER LIST pada Dialog
          side: const BorderSide(
            color: Color(0xFFFBA944), // Warna list/border terang
            width: 2.0, 
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // JUDUL DIALOG
              const Text(
                "Delete Habit?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              // DESKRIPSI
              const Text(
                "The progress this habit cannot\nbe recovered once deleted.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.orange100, 
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              
              // TOMBOL AKSI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // TOMBOL DELETE (Kiri)
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: AppColors.orange500, 
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  // TOMBOL CANCEL dengan CustomButton dan Efek Light/Glow (Kanan)
                  Container(
                    width: 140, // Ukuran lebar pas
                    height: 44, // Ukuran tinggi pas
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22), // Dibulatkan
                      // EFEK LIGHT/GLOW di sekitar tombol
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFBA944).withOpacity(0.35), 
                          blurRadius: 15, // Seberapa menyebar cahayanya
                          spreadRadius: 2, 
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CustomButton(
                      text: "Cancel",
                      onTap: () => Navigator.pop(context, false),
                      // Karena CustomButton punya style sendiri, 
                      // ukuran dan batas (radius) diatur oleh Container ini.
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
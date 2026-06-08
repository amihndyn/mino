import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/core/constants/app_colors.dart';

class ActivityItemCard extends StatelessWidget { // 🔥 1. UBAH KE STATELESSWIDGET AGAR DIKENDALIKAN OLEH BLOC
  final String title;
  final String? emoji;
  final String? imageAsset;
  final bool isCompleted; // 🔥 2. TERIMA STATUS LANGSUNG DARI MODEL LARAVEL
  final VoidCallback? onToggle; // 🔥 3. CALLBACK BARU UNTUK AKSI CENTANG
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ActivityItemCard({
    super.key,
    required this.title,
    required this.isCompleted, // Wajib diisi dari data habits list
    this.emoji,
    this.imageAsset,
    this.onToggle,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const Color cardBgColor = Color(0xffF6E5CD);
    const Color darkBrownColor = Color(0xff422E22);
    
    const Color editBtnBgColor = Color(0xFFCFCFCF); 
    const Color editBtnIconColor = Color(0xFF1E1E1E); 
    const Color deleteBtnBgColor = Color(0xFFC02A2A); 
    const Color deleteBtnIconColor = Color(0xffF6E5CD); 

    Widget iconWidget;
    if (imageAsset != null && imageAsset!.isNotEmpty) {
      iconWidget = Image.asset(
        imageAsset!,
        width: 38,
        height: 38,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            Icons.image_not_supported_rounded,
            size: 24,
            color: darkBrownColor,
          ),
        ),
      );
    } else if (emoji != null && emoji!.isNotEmpty) {
      iconWidget = Text(
        emoji!,
        style: const TextStyle(fontSize: 30),
      );
    } else {
      iconWidget = const SizedBox(width: 30, height: 30);
    }

    return Slidable(
      key: ValueKey(title),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25, 
        children: [
          // TOMBOL EDIT
          Expanded(
            child: CustomSlidableAction(
              onPressed: (context) {
                if (onEdit != null) onEdit!();
              },
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                width: 44, 
                height: 44,
                margin: const EdgeInsets.only(left: 6, right: 2), 
                decoration: BoxDecoration(
                  color: editBtnBgColor,
                  borderRadius: BorderRadius.circular(16), 
                ),
                child: const Icon(
                  Icons.edit_rounded,
                  color: editBtnIconColor, 
                  size: 26, 
                ),
              ),
            ),
          ),
          
          // TOMBOL HAPUS
          Expanded(
            child: CustomSlidableAction(
              onPressed: (context) {
                if (onDelete != null) onDelete!();
              },
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                width: 44, 
                height: 44,
                margin: const EdgeInsets.only(left: 2, right: 6),
                decoration: BoxDecoration(
                  color: deleteBtnBgColor,
                  borderRadius: BorderRadius.circular(16), 
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: deleteBtnIconColor,
                  size: 28, 
                ),
              ),
            ),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.coklat600,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  // 🔥 4. TAMBAHKAN EFEK CORET CORET JIKA SAKLAR COMPLETED AKTIF
                  decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: onToggle, // 🔥 5. JALANKAN FUNGSINYA KE BLOC SAAT DI-TAP
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: darkBrownColor,
                    width: 2.2,
                  ),
                  color: isCompleted ? darkBrownColor : Colors.transparent,
                ),
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        color: cardBgColor,
                        size: 18,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
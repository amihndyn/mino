import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/habit/edit_uniqur_habit_page.dart';

class HabitItemCard extends StatelessWidget {
  final int habitId; // 🟢 TAMBAHAN: Untuk tracking id habit
  final BuildContext pageContext; // 🟢 TAMBAHAN: Menyimpan root context halaman utama
  final String title;
  final String emoji;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(bool?)? onEditSuccess; // 🟢 Menerima callback status setelah edit selesai
  final VoidCallback? onTimer; 
  final bool showTutorial;
  final VoidCallback? onTutorialComplete;

  const HabitItemCard({
    super.key,
    required this.habitId, // 🟢 Wajib diisi
    required this.pageContext, // 🟢 Wajib diisi
    required this.title,
    required this.emoji,
    required this.isCompleted,
    required this.onToggle,
    required this.onDelete,
    this.onEditSuccess, // 🟢 Ganti dari onEdit biasa
    this.onTimer, 
    this.showTutorial = false,
    this.onTutorialComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.42, 
          children: [
            // ── ⏱️ 1. TOMBOL TIMER ──
            CustomSlidableAction(
              onPressed: (slidableContext) { 
                Slidable.of(slidableContext)?.close(); // Tutup slide
                onTimer?.call(); 
              }, 
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(width: 44, height: 44, margin: const EdgeInsets.only(left: 6), decoration: BoxDecoration(color: AppColors.orange200, borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.timer_rounded, color: Colors.black, size: 24))),
            ),
            
            // ── 📝 2. TOMBOL EDIT (PERBAIKAN UTAMA 🎯) ──
            CustomSlidableAction(
              onPressed: (slidableContext) async { 
                // Tutup slidable terlebih dahulu sebelum navigasi
                Slidable.of(slidableContext)?.close(); 

                // Lakukan navigasi tunggal menggunakan pageContext halaman utama
                final bool? updated = await Navigator.push<bool>(
                  pageContext,
                  MaterialPageRoute(
                    builder: (_) => EditHabitPage( 
                      habitId: habitId,
                      habitName: title,
                    ),
                  ),
                );

                // Jika sukses edit, kirim info true ke parent halaman utama untuk refresh data
                if (updated == true) {
                  onEditSuccess?.call(updated);
                }
              }, 
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(width: 44, height: 44, margin: const EdgeInsets.only(left: 6), decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.edit_rounded, color: Colors.black, size: 24))),
            ),
            
            // ── 🗑️ 3. TOMBOL DELETE (PERBAIKAN UTAMA 🎯) ──
            CustomSlidableAction(
              onPressed: (slidableContext) { 
                // Tutup slidable dulu agar tidak racing overlay dialognya
                Slidable.of(slidableContext)?.close(); 
                onDelete(); 
              }, 
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(width: 44, height: 44, margin: const EdgeInsets.only(left: 6), decoration: BoxDecoration(color: const Color(0xFFC92A2A), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.delete_rounded, color: Colors.white, size: 24))),
            ),
          ],
        ),
        child: Builder(
          builder: (slidableContext) {
            if (showTutorial) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                final slidable = Slidable.of(slidableContext);
                if (slidable != null) {
                  slidable.openEndActionPane(); 
                  await Future.delayed(const Duration(milliseconds: 1200)); 
                  slidable.close(); 
                  onTutorialComplete?.call(); 
                }
              });
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(color: const Color(0xFFEEDDCC), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title, 
                      style: TextStyle(
                        color: const Color(0xFF4A3A2A), 
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onToggle, 
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24, height: 24, 
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        color: isCompleted ? const Color(0xFF4A3A2A) : Colors.transparent,
                        border: Border.all(color: const Color(0xFF4A3A2A), width: 1.5)
                      ),
                      child: isCompleted ? const Icon(Icons.check, color: Color(0xFFEEDDCC), size: 16) : null,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
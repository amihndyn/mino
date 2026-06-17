import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/habit/edit_uniqur_habit_page.dart'; // Sesuai import asli Anda

class HabitItemWidget extends StatefulWidget {
  final int habitId;
  final BuildContext pageContext;
  final String? iconPath;
  final String title;
  final bool isCompleted;
  final VoidCallback onCheckTap;
  final VoidCallback onTimerTap;
  final Function(bool?) onEditSuccess; // Diubah ke bool? agar fleksibel menangkap hasil pop
  final VoidCallback onDelete;

  const HabitItemWidget({
    super.key,
    required this.habitId,
    required this.pageContext,
    required this.iconPath,
    required this.title,
    required this.isCompleted,
    required this.onCheckTap,
    required this.onTimerTap,
    required this.onEditSuccess,
    required this.onDelete,
  });

  @override
  State<HabitItemWidget> createState() => _HabitItemWidgetState();
}

class _HabitItemWidgetState extends State<HabitItemWidget> {
  late bool _localCompleted;

  @override
  void initState() {
    super.initState();
    _localCompleted = widget.isCompleted;
  }

  @override
  void didUpdateWidget(covariant HabitItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title || oldWidget.isCompleted != widget.isCompleted) {
      setState(() {
        _localCompleted = widget.isCompleted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey('slidable_${widget.habitId}'), // Gunakan ID unik agar Slidable tidak salah render posisi
        endActionPane: ActionPane(
  motion: const ScrollMotion(),
  extentRatio: 0.44, 
  children: [
    // ── ⏱️ BUTTON TIMER ──
    CustomSlidableAction(
      onPressed: (context) => widget.onTimerTap(),
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Container(
        width: 44, 
        height: 44, 
        margin: const EdgeInsets.symmetric(horizontal: 4), 
        decoration: BoxDecoration(
          color: AppColors.biru100, 
          borderRadius: BorderRadius.circular(12),
        ), 
        child: const Center(
          child: Icon(Icons.timer_rounded, color: Colors.black, size: 24),
        ),
      ),
    ),
    
    // ── 📝 BUTTON EDIT ──
    CustomSlidableAction(
      onPressed: (slidableContext) async {
        // 1. Tutup slidable-nya dulu biar bersih
        Slidable.of(slidableContext)?.close();

        // 2. 🟢 PERBAIKAN: Gunakan widget.pageContext (bukan slidableContext) agar Navigasi stabil
        final bool? updated = await Navigator.push<bool>(
          widget.pageContext,
          MaterialPageRoute(
            builder: (_) => EditHabitPage( 
              habitId: widget.habitId,
              habitName: widget.title,
            ),
          ),
        );

        // 3. Jalankan callback jika ada perubahan data
        if (updated == true) {
          widget.onEditSuccess(updated);
        }
      },
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Container(
        width: 44, 
        height: 44, 
        margin: const EdgeInsets.symmetric(horizontal: 4), 
        decoration: BoxDecoration(
          color: AppColors.coklat100, 
          borderRadius: BorderRadius.circular(12),
        ), 
        child: const Center(
          child: Icon(Icons.edit_rounded, color: AppColors.orange800, size: 24),
        ),
      ),
    ),
    
    // ── 🗑️ BUTTON DELETE ──
    CustomSlidableAction(
      onPressed: (slidableContext) {
        // 1. Tutup slidable-nya dulu biar overlay dialog tidak error
        Slidable.of(slidableContext)?.close();

        // 2. 🟢 PERBAIKAN: Langsung panggil onDelete (yang didalamnya membawa rootContext halaman utama)
        widget.onDelete();
      },
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Container(
        width: 44, 
        height: 44, 
        margin: const EdgeInsets.symmetric(horizontal: 4), 
        decoration: BoxDecoration(
          color: const Color(0xFFBE1D1D), 
          borderRadius: BorderRadius.circular(12),
        ), 
        child: const Center(
          child: Icon(Icons.delete_rounded, color: AppColors.orange100, size: 24),
        ),
      ),
    ),
  ],
),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: _localCompleted ? const Color(0xFFDCD0C0) : const Color(0xFFEEDDCC), 
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              widget.iconPath != null
                  ? Image.asset(
                      widget.iconPath!,
                      width: 28,
                      height: 28,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.star, color: Color(0xFF4A3A2A), size: 28),
                    )
                  : const Icon(Icons.star, color: Color(0xFF4A3A2A), size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.title, 
                  textAlign: TextAlign.center, 
                  style: const TextStyle(
                    color: AppColors.coklat800, 
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _localCompleted = !_localCompleted;
                  });
                  widget.onCheckTap();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _localCompleted ? Colors.green : Colors.transparent, 
                    border: Border.all(
                      color: _localCompleted ? Colors.green : const Color(0xFF4A3A2A), 
                      width: 1.5,
                    ),
                  ),
                  child: _localCompleted 
                      ? const Icon(Icons.check, size: 18, color: Colors.white) 
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
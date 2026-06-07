import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/core/constants/app_colors.dart';

class ActivityItemCard extends StatefulWidget {
  final String title;
  final String? emoji;
  final String? imageAsset;
  final bool initialCompleted;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ActivityItemCard({
    super.key,
    required this.title,
    this.emoji,
    this.imageAsset,
    this.initialCompleted = false,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<ActivityItemCard> createState() => _ActivityItemCardState();
}

class _ActivityItemCardState extends State<ActivityItemCard> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.initialCompleted;
  }

  void toggleChecklist() {
    setState(() {
      isCompleted = !isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color cardBgColor = Color(0xffF6E5CD);
    const Color darkBrownColor = Color(0xff422E22);
    
    // Warna khusus untuk tombol Slidable menyesuaikan gambar
    const Color editBtnBgColor = Color(0xFFCFCFCF); // Abu-abu terang
    const Color editBtnIconColor = Color(0xFF1E1E1E); // Gelap kehitaman
    const Color deleteBtnBgColor = Color(0xFFC02A2A); // Merah
    const Color deleteBtnIconColor = Color(0xffF6E5CD); // Krem

    Widget iconWidget;
    if (widget.imageAsset != null) {
      iconWidget = Image.asset(
        widget.imageAsset!,
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
    } else if (widget.emoji != null) {
      iconWidget = Text(
        widget.emoji!,
        style: const TextStyle(fontSize: 30),
      );
    } else {
      iconWidget = const SizedBox(width: 30, height: 30);
    }

    return Slidable(
      key: ValueKey(widget.title),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        // extentRatio dikecilkan dari 0.40 menjadi 0.34 
        // agar areanya lebih pas dan tombol tidak melebar
        extentRatio: 0.25, 
        children: [
          // TOMBOL EDIT
          Expanded(
            child: CustomSlidableAction(
              onPressed: (context) {
                if (widget.onEdit != null) widget.onEdit!();
              },
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                width: 44, 
                height: 44,
                // Margin diubah agar lebih rapat ke tombol Hapus
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
                if (widget.onDelete != null) widget.onDelete!();
              },
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                width: 44, 
                height: 44,
                // Margin kiri dikecilkan agar mepet dengan tombol Edit
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
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.coklat600,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  decoration: TextDecoration.none, 
                ),
              ),
            ),
            GestureDetector(
              onTap: toggleChecklist,
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
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChallengeItemCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final int current;
  final int total;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback? onTimer;
  
  // 🔥 Tambahkan 2 variabel ini
  final bool showTutorial;
  final VoidCallback? onTutorialComplete;

  const ChallengeItemCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.current,
    required this.total,
    required this.isCompleted,
    required this.onToggle,
    required this.onDelete,
    this.onTimer,
    this.showTutorial = false, // 🔥 Default false
    this.onTutorialComplete,   // 🔥
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.28,
          children: [
            CustomSlidableAction(
              onPressed: (context) {onTimer?.call();},
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(width: 44, height: 44, margin: const EdgeInsets.only(left: 6), decoration: BoxDecoration(color: const Color(0xFFC4F0FF), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.timer_rounded, color: Colors.black, size: 24))),
            ),
            CustomSlidableAction(
              onPressed: (context) => onDelete(),
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(width: 44, height: 44, margin: const EdgeInsets.only(left: 6), decoration: BoxDecoration(color: const Color(0xFFC92A2A), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.delete_rounded, color: Colors.white, size: 24))),
            ),
          ],
        ),
        // 🔥 Bungkus Container dengan Builder
        child: Builder(
          builder: (slidableContext) {
            // Logika geser otomatis
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(color: const Color(0xFF5C4731), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.star, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: total == 0 ? 0 : current / total,
                                  backgroundColor: Colors.white24, color: const Color(0xFFE6A84A), minHeight: 6,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('$current/$total', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: onToggle,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 26, height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted ? const Color(0xFFE6A84A) : Colors.transparent,
                        border: Border.all(color: isCompleted ? const Color(0xFFE6A84A) : Colors.white, width: 1.5),
                      ),
                      child: isCompleted ? const Icon(Icons.check, color: Colors.black, size: 18) : null,
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
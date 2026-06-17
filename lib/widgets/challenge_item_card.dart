import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/pages/timer/timer_page.dart';

class ChallengeItemCard extends StatelessWidget {
  final int id;
  final String iconPath;
  final String title;
  final int current;
  final int total;
  final bool isActive;
  final Function(BuildContext) onDeletePressed;
  final Function() onTap;

  const ChallengeItemCard({
    super.key,
    required this.id,
    required this.iconPath,
    required this.title,
    required this.current,
    required this.total,
    this.isActive = true,
    required this.onDeletePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.34,
          children: [
            // 1. TOMBOL STOPWATCH
            CustomSlidableAction(
              onPressed: (ctx) {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (context) => TimerPage(
                      habitId: id,
                      habitName: title,
                    ),
                  ),
                );
              },
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFC4F0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.timer_rounded, color: Colors.black, size: 24),
                ),
              ),
            ),

            // 2. TOMBOL DELETE
            CustomSlidableAction(
              onPressed: onDeletePressed,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFC92A2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.delete_rounded, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF5C4731) : const Color(0xFF2B2521),
              borderRadius: BorderRadius.circular(16),
              border: isActive
                  ? Border.all(color: const Color(0xFFE6A84A).withOpacity(0.3), width: 1.2)
                  : Border.all(color: Colors.white10, width: 1),
            ),
            child: Row(
              children: [
                Opacity(
                  opacity: isActive ? 1.0 : 0.4,
                  child: Image.asset(
                    iconPath,
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.star, color: Color(0xFFE6A84A));
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.white38,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: total > 0 ? (current / total) : 0,
                                backgroundColor: Colors.white12,
                                color: isActive ? const Color(0xFFE6A84A) : Colors.white24,
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$current/$total',
                            style: TextStyle(
                              color: isActive ? Colors.white.withOpacity(0.8) : Colors.white24,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: !isActive ? const Color(0xFFE6A84A) : Colors.transparent,
                    border: Border.all(
                      color: isActive ? Colors.white54 : const Color(0xFFE6A84A),
                      width: 1.5,
                    ),
                  ),
                  child: !isActive
                      ? const Icon(Icons.check, color: Colors.black, size: 16)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
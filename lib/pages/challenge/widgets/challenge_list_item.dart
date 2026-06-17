import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/pages/timer/timer_page.dart';
// TODO: Sesuaikan path import PopUpConfirmation di bawah ini
import 'package:mino/widgets/popUp/pop_up_info.dart'; 

class ChallengeListItem extends StatelessWidget {
  final int id;
  final String iconPath;
  final String title;
  final int current;
  final int total;
  final bool isCheckedToday;

  const ChallengeListItem({
    super.key,
    required this.id,
    required this.iconPath,
    required this.title,
    required this.current,
    required this.total,
    this.isCheckedToday = false,
  });

  void _showDeleteDialog(BuildContext pageContext, int challengeId, String title) {
    showDialog(
      context: pageContext,
      builder: (BuildContext dialogContext) {
        return PopUpConfirmation(
          title: 'Delete Challenge?',
          description: 'The progress for "$title" cannot\nbe recovered once deleted. 💎',
          leftButtonText: 'Cancel',
          rightButtonText: 'Delete',
          topIcon: const Icon(
            Icons.warning_rounded,
            color: Color(0xFFE6A84A),
            size: 44,
          ),
          onLeftTap: () => Navigator.pop(dialogContext),
          onRightTap: () {
            Navigator.pop(dialogContext);
            pageContext.read<UserChallengeBloc>().add(
                  UserChallengeEvent.deleteChallenge(challengeId),
                );
          },
        );
      },
    );
  }

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
            CustomSlidableAction(
              onPressed: (ctx) {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (ctx) => TimerPage(habitId: id, habitName: title),
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
                  child: Icon(
                    Icons.timer_rounded,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
            CustomSlidableAction(
              onPressed: (ctx) => _showDeleteDialog(context, id, title),
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
                  child: Icon(
                    Icons.delete_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF5C4731),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE6A84A).withOpacity(0.3),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              // ── 📚 UKURAN GAMBAR DIUBAH MENJADI SEPERTI BUKU (PORTRAIT) ──
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  iconPath,
                  width: 40,  // Lebar proporsional buku
                  height: 56, // Tinggi proporsional buku (Rasio ~1:1.4)
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 56,
                      color: Colors.white.withOpacity(0.05),
                      child: const Icon(
                        Icons.star,
                        color: Color(0xFFE6A84A),
                        size: 24,
                      ),
                    );
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
                      style: const TextStyle(
                        color: Colors.white,
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
                              color: const Color(0xFFE6A84A),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '$current/$total',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
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
              GestureDetector(
                onTap: () {
                  context.read<UserChallengeBloc>().add(
                        UserChallengeEvent.checkInChallenge(id),
                      );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCheckedToday ? const Color(0xFF66BB6A) : Colors.transparent,
                    border: Border.all(
                      color: isCheckedToday ? const Color(0xFF66BB6A) : Colors.white54,
                      width: 2,
                    ),
                  ),
                  child: isCheckedToday
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
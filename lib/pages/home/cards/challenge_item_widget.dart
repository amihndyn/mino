import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/widgets/popUp/pop_up_gagal.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/providers/challenge_provider.dart';
import 'package:mino/pages/timer/timer_page.dart';

class ChallengeItemWidget extends StatelessWidget {
  final dynamic challenge;
  final VoidCallback onDelete;
  final VoidCallback onTimerTap;

  const ChallengeItemWidget({
    super.key,
    required this.challenge,
    required this.onDelete,
    required this.onTimerTap,
  });

  @override
  Widget build(BuildContext context) {
    final challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
    final now = DateTime.now();
    
    bool isCheckedToday = false;
    if (challenge.lastProgressDate != null) {
      try {
        final lastDate = DateTime.parse(challenge.lastProgressDate!).toLocal();
        isCheckedToday = lastDate.year == now.year &&
            lastDate.month == now.month &&
            lastDate.day == now.day;
      } catch (_) {}
    }

    final localChallengeData = challengeProvider.getChallengeById(challenge.challengeId);
    String finalImageAsset = 'assets/icons/tension.png';
    
    if (localChallengeData != null && localChallengeData.detailImageAsset.isNotEmpty) {
      finalImageAsset = localChallengeData.detailImageAsset;
    } else if (localChallengeData != null && localChallengeData.imageAsset.isNotEmpty) {
      finalImageAsset = localChallengeData.imageAsset;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey('home_challenge_${challenge.challengeId}'),
        groupTag: 'challenge_group',
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.35,
          children: [
            _buildTimerAction(context),
            _buildDeleteAction(context),
          ],
        ),
        child: _buildChallengeCard(context, finalImageAsset, isCheckedToday),
      ),
    );
  }

  Widget _buildTimerAction(BuildContext context) {
    return CustomSlidableAction(
      onPressed: (_) => onTimerTap(),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Color(0xFFC4F0FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.timer,
          color: Colors.black,
        ),
      ),
    );}

  Widget _buildDeleteAction(BuildContext context) {
    return CustomSlidableAction(
      onPressed: (context) => onDelete(),
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
    );
  }

  Widget _buildChallengeCard(BuildContext context, String imageAsset, bool isCheckedToday) {
    return Container(
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
          _buildChallengeImage(imageAsset),
          const SizedBox(width: 16),
          Expanded(child: _buildChallengeInfo()),
          const SizedBox(width: 16),
          _buildCheckButton(context, isCheckedToday),
        ],
      ),
    );
  }

  Widget _buildChallengeImage(String imageAsset) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        imageAsset,
        width: 28,
        height: 35,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.star, color: Color(0xFFE6A84A)),
      ),
    );
  }

  Widget _buildChallengeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          challenge.name,
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
                  value: challenge.requiredDays > 0
                      ? (challenge.progressDays / challenge.requiredDays)
                      : 0,
                  backgroundColor: Colors.white12,
                  color: const Color(0xFFE6A84A),
                  minHeight: 6,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${challenge.progressDays}/${challenge.requiredDays}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckButton(BuildContext context, bool isCheckedToday) {
    return GestureDetector(
      onTap: () {
  context.read<UserChallengeBloc>().add(
        UserChallengeEvent.checkInChallenge(challenge.challengeId),
      );

  Future.delayed(const Duration(milliseconds: 300), () {
    context.read<UserChallengeBloc>().add(
          const UserChallengeEvent.fetchUserChallenges(),
        );
    context.read<DashboardBloc>().add(
          const DashboardEvent.fetchDashboardData(),
        );
  });
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
    );
  }
}
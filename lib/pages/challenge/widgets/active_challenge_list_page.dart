import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/providers/challenge_provider.dart';
import 'package:mino/pages/challenge/widgets/challenge_top_progress_card.dart';
import 'package:mino/pages/challenge/widgets/challenge_list_item.dart';
import 'package:mino/widgets/popUp/pop_up_reminder.dart';

class ActiveChallengeListPage extends StatelessWidget {
  const ActiveChallengeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final challengeProvider = context.watch<ChallengeProvider>();
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: BlocBuilder<UserChallengeBloc, UserChallengeState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  error: (message) => Center(
                    child: Text(
                      "Gagal memuat data: $message",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  success: (myActiveChallenges) {
                    final int totalCount = myActiveChallenges.length;

                    // ── 🔄 SINKRONISASI HITUNGAN PROGRESS TOTAL HARI INI ──
                    final int completedCount = myActiveChallenges.where((c) {
                      if (c.lastProgressDate == null) return false;
                      try {
                        final lastDate = DateTime.parse(c.lastProgressDate!);
                        return lastDate.year == now.year &&
                            lastDate.month == now.month &&
                            lastDate.day == now.day;
                      } catch (_) {
                        return false;
                      }
                    }).length;

                    int totalDiamondsEarned = completedCount * 50;
                    final double progressValue = totalCount > 0
                        ? (completedCount / totalCount)
                        : 0.0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Halaman
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const Text(
                                "Today's challenges",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Body Content
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ChallengeTopProgressCard(
                                  completed: completedCount,
                                  total: totalCount,
                                  progress: progressValue,
                                  diamonds: totalDiamondsEarned,
                                ),
                                const SizedBox(height: 32),
                                const Text(
                                  'The overall challenge',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                myActiveChallenges.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 40,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'No active challenges yet.\nGo to Find page to join one! 🎯',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 14,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: myActiveChallenges.length,
                                        itemBuilder: (context, index) {
                                          final item = myActiveChallenges[index];
                                          final int currentProgressDay = item.progressDays;
                                          final int durationDays = item.requiredDays;

                                          // ── Deteksi Status Ceklis Hari Ini ──
                                          bool checkedToday = false;
                                          if (item.lastProgressDate != null) {
                                            try {
                                              final lastDate = DateTime.parse(item.lastProgressDate!);
                                              checkedToday = lastDate.year == now.year &&
                                                  lastDate.month == now.month &&
                                                  lastDate.day == now.day;
                                            } catch (_) {
                                              checkedToday = false;
                                            }
                                          }

                                          final localChallengeData = challengeProvider.getChallengeById(item.challengeId);
                                          final String iconPath = (localChallengeData != null && localChallengeData.detailImageAsset.isNotEmpty)
                                              ? localChallengeData.detailImageAsset
                                              : 'assets/images/clean.png';

                                          return ChallengeListItem(
                                            key: ValueKey(item.challengeId),
                                            id: item.challengeId,
                                            iconPath: iconPath,
                                            title: item.name,
                                            current: currentProgressDay,
                                            total: durationDays,
                                            isCheckedToday: checkedToday,
                                          );
                                        },
                                      ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  orElse: () => const Center(
                    child: CircularProgressIndicator(color: Colors.amber),
                  ),
                );
              },
            ),
          ),
          if (challengeProvider.showWarning)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: PopUpReminder(
                onClose: () {
                  challengeProvider.dismissWarning();
                },
              ),
            ),
        ],
      ),
    );
  }
}
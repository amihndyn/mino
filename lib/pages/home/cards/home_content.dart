import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';
import 'package:mino/core/data/model/response/user_challenge_response_model.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/pages/habit/widgets/habit_item_widget.dart';
import 'package:mino/pages/home/cards/challenge_item_widget.dart'; 
import 'package:mino/pages/home/cards/loading_widget.dart';
import 'package:mino/pages/home/widgets/home_header.dart';
import 'package:mino/pages/home/widgets/todays_progress_card.dart';
import 'package:mino/providers/habit_provider.dart'; 
import 'package:mino/pages/timer/timer_page.dart';
import 'package:mino/pages/habit/widgets/active_habit_list_page.dart';
import 'package:mino/pages/challenge/widgets/active_challenge_list_page.dart';
import 'package:mino/pages/home/cards/home_body.dart'; 

class HomeContent extends StatelessWidget {
  final int? currentDiamonds;
  final Function(int newDiamonds) onDiamondsChanged;

  const HomeContent({
    super.key,
    required this.currentDiamonds,
    required this.onDiamondsChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Menyimpan root context utama agar aman diakses dari callback manapun
    final BuildContext rootContext = context;

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, dashboardState) {
        return dashboardState.when(
          initial: () => const LoadingWidget(),
          loading: () => const LoadingWidget(),
          error: (message) => Scaffold(
            body: Center(child: Text(message)),
          ),
          success: (response) {
            final dashboardData = response.dashboard;
            final user = dashboardData?.user;
            final summary = dashboardData?.summary;
            
            final List<TodayHabit> habitsList = dashboardData?.todayHabits ?? []; 
            final displayedHabits = habitsList.take(2).toList();
            final displayDiamonds = currentDiamonds ?? (user?.diamonds ?? 0);

            return BlocBuilder<UserChallengeBloc, UserChallengeState>(
              builder: (context, challengeState) {
                final completedChallenges = _getCompletedChallengesCount(challengeState);
                final totalChallenges = _getTotalChallengesCount(challengeState);
                
                final completedHabits = summary?.habitsCompletedToday ?? 0;
                final totalHabits = summary?.habitsTotal ?? 0;

                return SafeArea(
                  bottom: false,
                  child: SlidableAutoCloseBehavior(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeHeader(
                            key: ValueKey('${displayDiamonds}_${user?.name}'),
                            name: user?.name ?? 'Guest',
                            diamonds: displayDiamonds,
                          ),
                          const SizedBox(height: 12),
                          
                          TodaysProgressCard(
                            key: ValueKey(
                              'progress_${completedHabits}_${totalHabits}_${completedChallenges}_$totalChallenges',
                            ),
                            completedHabits: completedHabits,
                            totalHabits: totalHabits,
                            completedChallenges: completedChallenges,
                            totalChallenges: totalChallenges,
                          ),
                          const SizedBox(height: 12),
                          
                          // ── 🎯 LIST HABITS ──
                         Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      "Today's Habits",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ActiveHabitListPage(),
          ),
        );
      },
      child: const Row(
        children: [
          Text(
            "See all",
            style: TextStyle(
              color: Color(0xFFE6A84A),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Color(0xFFE6A84A),
          ),
        ],
      ),
    ),
  ],
),
                          const SizedBox(height: 12),

                          if (habitsList.isEmpty)
                            const Center(
                              child: Text(
                                "No habits for today.",
                                style: TextStyle(color: Colors.white60),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: displayedHabits.length,
                              padding: const EdgeInsets.only(top: 12, bottom: 16),
                              separatorBuilder: (context, index) => const SizedBox(height: 8),
                              itemBuilder: (itemContext, index) { // 🟢 Ganti ke itemContext agar tidak tabrakan
                                final habit = displayedHabits[index];
                                final String habitName = habit.habitName ?? 'Untitled';
                                final bool isCompleted = habit.isCompletedToday ?? false;
                                final int idHabit = habit.userHabitId ?? 0;

                                final String? fetchedIconPath = itemContext
                                    .read<HabitProvider>()
                                    .getIconPath(habitName);

                                return HabitItemWidget(
                                  habitId: idHabit,
                                  pageContext: rootContext, 
                                  iconPath: fetchedIconPath,
                                  title: habitName,
                                  isCompleted: isCompleted,
                                  onCheckTap: () {
  itemContext.read<DashboardBloc>().add(
    DashboardEvent.toggleHabit(
      idHabit,
      isCompleted,
    ),
  );

  Future.delayed(
    const Duration(milliseconds: 500),
    () {
      itemContext.read<DashboardBloc>().add(
        const DashboardEvent.fetchDashboardData(),
      );
    },
  );
},
                                  onTimerTap: () {
                                    Navigator.push(
                                      itemContext,
                                      MaterialPageRoute(
                                        builder: (_) => TimerPage(
                                          habitId: idHabit,
                                          habitName: habitName,
                                        ),
                                      ),
                                    );
                                  },
                                 onDelete: () {
                                  print("DELETE HABIT $idHabit");
  HomeBody.openDeleteHabitDialog(
    rootContext,
    idHabit,
    habitName,
  );
},

onEditSuccess: (isSuccess) {
  if (isSuccess == true && itemContext.mounted) {
    itemContext.read<DashboardBloc>().add(
      const DashboardEvent.fetchDashboardData(),
    );
  }
},
                                );
                              },
                            ),
                          
                          const SizedBox(height: 16),
                          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      "Active Challenges",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ActiveChallengeListPage(),
          ),
        );
      },
      child: const Row(
        children: [
          Text(
            "See all",
            style: TextStyle(
              color: Color(0xFFE6A84A),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Color(0xFFE6A84A),
          ),
        ],
      ),
    ),
  ],
),
                          const SizedBox(height: 12),

                          challengeState.maybeWhen(
                            loading: () => const Center(child: CircularProgressIndicator()),
                            error: (msg) => Center(
                              child: Text(
                                msg,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            needRevive: (challengeId, message) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Text(message),
                                      const SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<UserChallengeBloc>().add(
                                                UserChallengeEvent.reviveChallenge(challengeId),
                                              );
                                        },
                                        child: const Text('Tebus 5 Diamond'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            success: (List<UserChallenge> challenges) {
                              if (challenges.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "No active challenges.",
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                );
                              }
                              final displayedChallenges = challenges.take(2).toList();

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: displayedChallenges.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 12),
                                itemBuilder: (challengeContext, index) {
                                 final challenge = displayedChallenges[index];

                                  return ChallengeItemWidget(
                                    key: ValueKey(challenge.id),
                                    challenge: challenge,
                                    onTimerTap: () {
                                      Navigator.push(
                                        challengeContext,
                                        MaterialPageRoute(
                                          builder: (_) => TimerPage(
                                            challengeId: challenge.id,
                                            challengeName: challenge.name,
                                          ),
                                        ),
                                      );
                                    },
                                    onDelete: () {
                                      HomeBody.openDeleteChallengeDialog(rootContext, challenge.id, challenge.name);
                                    },
                                  );
                                },
                              );
                            },
                            orElse: () => const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 13),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  int _getCompletedChallengesCount(UserChallengeState state) {
    int completedCount = 0;
    state.maybeWhen(
      success: (challengesData) {
        final List<dynamic> challenges = challengesData;
        final now = DateTime.now();
        completedCount = challenges.where((c) {
          final dynamic challenge = c;
          String? lastProgressDate;
          
          try {
            lastProgressDate = challenge.lastProgressDate;
          } catch (_) {
            lastProgressDate = null;
          }

          if (lastProgressDate == null) return false;
          try {
            final lastDate = DateTime.parse(lastProgressDate).toLocal();
            return lastDate.year == now.year &&
                lastDate.month == now.month &&
                lastDate.day == now.day;
          } catch (_) {
            return false;
          }
        }).length;
      },
      orElse: () {},
    );
    return completedCount;
  }

  int _getTotalChallengesCount(UserChallengeState state) {
    int totalCount = 0;
    state.maybeWhen(
      success: (challengesData) {
        final List<dynamic> challenges = challengesData;
        totalCount = challenges.length;
      },
      orElse: () {},
    );
    return totalCount;
  }
}
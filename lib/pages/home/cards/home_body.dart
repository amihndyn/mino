import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/home/cards/home_content.dart';
import 'package:mino/providers/challenge_provider.dart';
import 'package:mino/widgets/popUp/pop_up_info.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  // 🟢 STATIC METHOD 1: Dipanggil langsung dari mana saja (termasuk HabitItemWidget / HomeContent)
  static void openDeleteHabitDialog(BuildContext context, int habitId, String name) {
    showDialog(
      context: context,
      builder: (ctx) => PopUpConfirmation(
        title: 'Delete Habit',
        description: 'Are you sure you want to delete "$name"?',
        leftButtonText: 'Cancel',
        rightButtonText: 'Delete',
        topIcon: const Text('⚠️', style: TextStyle(fontSize: 40)),
        onLeftTap: () => Navigator.pop(ctx),
        onRightTap: () {
          // Pop dialognya dulu
          Navigator.pop(ctx);
          
          if (!context.mounted) return;

          // Jalankan proses hapus ke Bloc memakai context utama halaman
          context.read<DashboardBloc>().add(
                DashboardEvent.deleteHabit(habitId),
              );

          // Tarik data terbaru secara sekuensial
          context.read<DashboardBloc>().add(
                const DashboardEvent.fetchDashboardData(),
              );
        },
      ),
    );
  }

  // 🟢 STATIC METHOD 2: Kita buatkan juga untuk Challenge sekalian agar arsitekturnya seragam
  static void openDeleteChallengeDialog(BuildContext context, int challengeId, String name) {
    showDialog(
      context: context,
      builder: (ctx) => PopUpConfirmation(
        title: 'Delete Challenge',
        description: 'Are you sure you want to delete "$name"?',
        leftButtonText: 'Cancel',
        rightButtonText: 'Delete',
        topIcon: const Text('⚠️', style: TextStyle(fontSize: 40)),
        onLeftTap: () => Navigator.pop(ctx),
        onRightTap: () {
          Navigator.pop(ctx);
          
          if (!context.mounted) return;

          context.read<UserChallengeBloc>().add(
                UserChallengeEvent.deleteChallenge(challengeId),
              );

          context.read<UserChallengeBloc>().add(
                const UserChallengeEvent.fetchUserChallenges(),
              );
        },
      ),
    );
  }

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int? _currentDiamonds;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserChallengeBloc, UserChallengeState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (challenges) {
                final challengeProvider = Provider.of<ChallengeProvider>(
                  context,
                  listen: false,
                );
                challengeProvider.clearChallenges();
                for (var challenge in challenges) {
                  challengeProvider.addChallengeFromNetwork(challenge);
                }
              },
              orElse: () {},
            );
          },
        ),
        BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (response) {
                if (!context.mounted) return;
                setState(() {
                  _currentDiamonds = response.dashboard?.user?.diamonds ?? 0;
                });
              },
              orElse: () {},
            );
          },
        ),
      ],
      // 🔥 PERBAIKAN DI SINI: Stack & HomeBackground dihapus agar tidak menjepit ukuran layar
      child: SizedBox.expand(
        child: HomeContent(
          currentDiamonds: _currentDiamonds,
          onDiamondsChanged: (newDiamonds) {
            if (!context.mounted) return;
            setState(() {
              _currentDiamonds = newDiamonds;
            });
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/home/cards/home_background.dart';
import 'package:mino/pages/home/cards/home_body.dart';
import 'package:mino/core/constants/app_colors.dart';

import '../../widgets/navbar/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshAllData();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _refreshAllData() {
    context.read<DashboardBloc>().add(
      const DashboardEvent.fetchDashboardData(),
    );
    context.read<UserChallengeBloc>().add(
      const UserChallengeEvent.fetchUserChallenges(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshAllData();
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.coklat900,
      // 🔥 FIX: Gunakan SizedBox.expand + Stack di sini agar background terkunci fullscreen
      body: SizedBox.expand(
        child: Stack(
          children: [
            // 1. Layer Paling Bawah: Pasang Background (Import dulu jika beda file)
            const HomeBackground(), 

            // 2. Layer Atas: Konten utama aplikasi kamu
            // Gunakan SafeArea agar konten tidak nabrak status bar HP (baterai/jam)
            const SafeArea(
              bottom: false, // Biar kontennya bisa mengalir sampai bawah navbar
              child: HomeBody(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}
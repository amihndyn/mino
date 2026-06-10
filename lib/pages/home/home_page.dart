import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Tetap pakai bloc untuk UI ini
import 'package:provider/provider.dart'; // 🔥 TAMBAHKAN INI untuk membaca ChallengeProvider
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/home/widgets/todays_progress_card.dart';
import 'package:mino/providers/challenge_provider.dart'; // 🔥 Import provider tantanganmu

import '../../widgets/navbar/bottom_navbar.dart';
import 'widgets/home_header.dart';
import 'widgets/daily_activities_section.dart';
import 'widgets/challenge_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    // 🔥 1. Pemicu API: Ambil data dashboard begitu halaman pertama kali dimuat
    // Sesuaikan 'const DashboardEvent.fetch()' dengan nama event fetch milik BLoC-mu (misal: GetDashboardData())
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardBloc>().add(
        const DashboardEvent.fetchDashboardData(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 2. Ambil data list tantangan dari ChallengeProvider bawaan MultiProvider-mu
    // Ini solusi cerdas supaya widget ChallengeSection kamu tidak nyari data ke BLoC yang emang ga ada data challengenya.
    final choiceChallenges = context.watch<ChallengeProvider>().challenges;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          /// BACKGROUND UTAMA
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          /// KONTEN UTAMA MENGGUNAKAN BLOCBUILDER
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (message) => Center(
                  child: Text(
                    "Gagal memuat data:\n$message",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                success: (response) {
                  // Bongkar objek utama dashboard hasil data model Laravel-mu
                  final dashboardData = response.dashboard;
                  final user = dashboardData?.user;
                  final summary = dashboardData?.summary;
                  final habits = dashboardData?.todayHabits ?? [];

                  return SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Builder(
                          builder: (context) {
                            // Ambil data user paling fresh yang ada di memori Bloc saat ini
                            final currentDiamonds = user?.diamonds ?? 0;
                            final currentName = user?.name ?? 'Guest';

                            return HomeHeader(
                              // Tambahkan key unik ini agar Flutter dipaksa merender ulang angka diamond baru
                              key: ValueKey('${user?.diamonds}_${user?.name}'),
                              name: currentName,
                              diamonds: currentDiamonds,
                            );
                          },
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              children: [
                                // 🔥 3. PROGRESS CARD (Ambil data summary habit dari Laravel)
                                // Jika TodaysProgressCard milikmu minta parameter challenge, isi sementara dengan 0
                                // sampai backend Laravel-mu menyediakan datanya di kelas Summary.
                                TodaysProgressCard(
                                  // Tambahkan key unik ini agar progress bar/lingkaran langsung berubah saat habit dicentang
                                  key: ValueKey(
                                    '${summary?.habitsCompletedToday}_${summary?.habitsTotal}',
                                  ),
                                  completedHabits:
                                      summary?.habitsCompletedToday ?? 0,
                                  totalHabits: summary?.habitsTotal ?? 0,
                                  completedChallenges: 0,
                                  totalChallenges: 0,
                                ),
                                const SizedBox(height: 24),

                                // 🔥 4. DAILY ACTIVITIES SECTION
                                DailyActivitiesSection(
                                  habits: habits,
                                  // habitsCompleted: summary?.habitsCompletedToday ?? 0,
                                  // habitsTotal: summary?.habitsTotal ?? 0,
                                ),
                                const SizedBox(height: 24),

                                // 🔥 5. CHALLENGE SECTION (Ambil aman dari Provider)
                                ChallengeSection(challenges: choiceChallenges),

                                // Ruang ekstra di bawah agar konten tidak tertutup navbar
                                const SizedBox(height: 120),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() {
            _navIndex = i;
          });
        },
      ),
    );
  }
}

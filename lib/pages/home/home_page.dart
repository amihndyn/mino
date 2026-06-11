import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // UI Ami
import 'package:flutter_bloc/flutter_bloc.dart'; // Logic Sausan
import 'package:provider/provider.dart'; // Logic Sausan
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/providers/challenge_provider.dart'; 

// Sesuaikan path import di bawah ini dengan struktur foldermu
import 'package:mino/core/data/model/response/dashboard_response.dart';
import 'package:mino/pages/challenge/widgets/active_challenge_list_page.dart';
import 'package:mino/pages/habit/widgets/active_habit_list_page.dart';
import 'package:mino/pages/home/widgets/todays_progress_card.dart';
import 'widgets/home_header.dart';
import '../../widgets/navbar/bottom_navbar.dart'; 

// Variabel global agar tutorial hanya jalan 1x selama aplikasi hidup (Ami)
bool _hasShownHabitTutorial = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;
  
  // 🔥 Map lokal agar tombol ceklis bisa ditekan tanpa merusak properti final model API
  final Map<int, bool> _toggledHabits = {};

  @override
  void initState() {
    super.initState();
    // 🔥 Pemicu API: Ambil data dashboard begitu halaman dimuat (Sausan)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardBloc>().add(
        const DashboardEvent.fetchDashboardData(),
      );
    });
  }

  // --- FUNGSI POP UP DELETE (Ami) ---
  void _showDeleteDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF332218),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Delete $type?', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text('The progress this $type cannot\nbe recovered once deleted. 💎', textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13, height: 1.4)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE6A84A), width: 1.5)),
                          alignment: Alignment.center,
                          child: const Text('Delete', style: TextStyle(color: Color(0xFFE6A84A), fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(color: const Color(0xFF4A3424), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: const Color(0xFFE6A84A).withOpacity(0.2), blurRadius: 10, spreadRadius: 1)]),
                          alignment: Alignment.center,
                          child: const Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Ambil data list tantangan dari ChallengeProvider (Sausan)
    final choiceChallenges = context.watch<ChallengeProvider>().challenges;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF1A110A), // UI Ami
      body: Stack(
        children: [
          // Background Image (Sama untuk keduanya)
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          // Main Content dibungkus BlocBuilder (Sausan)
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
                loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
                error: (message) => Center(
                  child: Text(
                    "Gagal memuat data:\n$message",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                success: (response) {
                  // Ekstrak data dari state success (Sausan)
                  final dashboardData = response.dashboard;
                  final user = dashboardData?.user;
                  final summary = dashboardData?.summary;
                  final habits = dashboardData?.todayHabits ?? [];

                  // Tampilkan UI Ami yang disuntik data Sausan
                  return SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Header (UI Ami + Data Sausan)
                          HomeHeader(
                            key: ValueKey('${user?.diamonds}_${user?.name}'),
                            name: user?.name ?? 'Guest',
                            diamonds: user?.diamonds ?? 0,
                          ),
                          const SizedBox(height: 24),

                          // 2. Card Progress (UI Ami + Data Sausan)
                          TodaysProgressCard(
                            key: ValueKey('${summary?.habitsCompletedToday}_${summary?.habitsTotal}'),
                            completedHabits: summary?.habitsCompletedToday ?? 0,
                            totalHabits: summary?.habitsTotal ?? 0,
                            completedChallenges: 0,
                            totalChallenges: 0,
                          ),
                          const SizedBox(height: 32),

                          // 3. Section Habit (UI Ami + List Dinamis Sausan)
                          _buildHabitSection(context, habits, summary),
                          const SizedBox(height: 32),

                          // 4. Section Challenge (UI Ami + List Dinamis Provider)
                          _buildChallengeSection(context, choiceChallenges),

                          const SizedBox(height: 120), // Spasi aman untuk Bottom NavBar
                        ],
                      ),
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
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }

  // ===========================================================================
  // SECTION HABIT (Logic Dinamis)
  // ===========================================================================
  Widget _buildHabitSection(BuildContext context, List<TodayHabit> habits, dynamic summary) {
    int completedHabits = summary?.habitsCompletedToday ?? 0;
    int totalHabits = summary?.habitsTotal ?? (habits.isNotEmpty ? habits.length : 1);
    double progress = totalHabits > 0 ? (completedHabits / totalHabits) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Your habit', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveHabitListPage())),
              child: Row(
                children: const [
                  Text('See all', style: TextStyle(color: Color(0xFFE6A84A), fontSize: 14)),
                  Icon(Icons.chevron_right, color: Color(0xFFE6A84A)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Mapping Data Habit Backend ke UI Slidable Ami
        if (habits.isEmpty)
          const Text('No habits for today. Take a rest! ☕', style: TextStyle(color: Colors.white70))
        else
          ...habits.asMap().entries.take(3).map((entry) {
            int index = entry.key;
            TodayHabit habit = entry.value;
            
            int habitId = habit.userHabitId ?? 0;
            // Cek status ceklis dari local state, jika belum ada ambil dari value API backend
            bool isCompleted = _toggledHabits.containsKey(habitId)
                ? _toggledHabits[habitId]!
                : (habit.isCompletedToday ?? false);

            // FIX: Menggunakan data asli model (habitName) menggantikan emoji/title lama yang merah
            return _buildHabitItem(
              context, 
              '✨', 
              habit.habitName ?? 'Habit', 
              isTutorial: index == 0, // Tutorial cuma muncul di item pertama
              isCompleted: isCompleted,
              habitId: habitId,
              streak: habit.streak ?? 0,
            );
          }).toList(),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(value: progress, backgroundColor: Colors.white24, color: const Color(0xFFE6A84A), minHeight: 6),
              ),
            ),
            const SizedBox(width: 12),
            Text('$completedHabits/$totalHabits habits completed', style: const TextStyle(color: Color(0xFFE6A84A), fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildHabitItem(BuildContext context, String emoji, String title, {bool isTutorial = false, bool isCompleted = false, int habitId = 0, int streak = 0}) {
    // UI Item persis seperti milik Ami
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.65,
          children: [
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(margin: const EdgeInsets.only(left: 8), decoration: BoxDecoration(color: const Color(0xFFC4F0FF), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.timer_rounded, color: Colors.black, size: 28))),
            ),
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(margin: const EdgeInsets.only(left: 8), decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.edit_rounded, color: Colors.black, size: 28))),
            ),
            CustomSlidableAction(
              onPressed: (context) => _showDeleteDialog(context, 'Habit'),
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(margin: const EdgeInsets.only(left: 8), decoration: BoxDecoration(color: const Color(0xFFC92A2A), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.delete_rounded, color: Colors.white, size: 28))),
            ),
          ],
        ),
        child: Builder(
          builder: (slidableContext) {
            if (isTutorial && !_hasShownHabitTutorial) {
              _hasShownHabitTutorial = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(const Duration(milliseconds: 1000), () {
                  Slidable.of(slidableContext)?.openEndActionPane();
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Slidable.of(slidableContext)?.close();
                  });
                });
              });
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(color: const Color(0xFFEEDDCC), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title, 
                          style: TextStyle(
                            color: const Color(0xFF4A3A2A), 
                            fontWeight: FontWeight.w500,
                            decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                        if (streak > 0) ...[
                          const SizedBox(height: 2),
                          Text(
                            '🔥 $streak day streak',
                            style: TextStyle(color: const Color(0xFF4A3A2A).withOpacity(0.6), fontSize: 11),
                          ),
                        ]
                      ],
                    ),
                  ),
                  
                  // Klik Ceklis Interaktif (Ami UI style)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggledHabits[habitId] = !isCompleted;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24, 
                      height: 24, 
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        color: isCompleted ? const Color(0xFF4A3A2A) : Colors.transparent,
                        border: Border.all(color: const Color(0xFF4A3A2A), width: 1.5),
                      ),
                      child: isCompleted
                          ? const Icon(Icons.check, color: Color(0xFFEEDDCC), size: 16)
                          : null,
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

  // ===========================================================================
  // SECTION CHALLENGE (Logic Dinamis)
  // ===========================================================================
  Widget _buildChallengeSection(BuildContext context, List challenges) {
    // Default dummy untuk progress jika tidak ada summary challenge dari backend
    int completedChallenges = 1; 
    int totalChallenges = challenges.isNotEmpty ? challenges.length : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Your Challenge', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveChallengeListPage())),
              child: Row(
                children: const [
                  Text('See all', style: TextStyle(color: Color(0xFFE6A84A), fontSize: 14)),
                  Icon(Icons.chevron_right, color: Color(0xFFE6A84A)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Mapping Data Challenge Backend ke UI Slidable Ami
        if (challenges.isEmpty)
          const Text('No active challenges. Take one!', style: TextStyle(color: Colors.white70))
        else
          ...challenges.take(2).map((challenge) {
            // CATATAN: Sesuaikan .title, .current, .total dengan model Dart kamu
            return _buildChallengeItem(
              context, 
              'assets/icons/tension.png', // Ikon sementara, bisa diganti pakai logic if/else
              challenge.title ?? challenge.name ?? 'Challenge', 
              challenge.currentProgress ?? 0, 
              challenge.target ?? 30
            );
          }).toList(),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(value: completedChallenges / totalChallenges, backgroundColor: Colors.white24, color: const Color(0xFFE6A84A), minHeight: 6),
              ),
            ),
            const SizedBox(width: 12),
            Text('$completedChallenges/$totalChallenges challenge completed', style: const TextStyle(color: Color(0xFFE6A84A), fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildChallengeItem(BuildContext context, String iconPath, String title, int current, int total) {
    // UI Item persis seperti milik Ami
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.45,
          children: [
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(margin: const EdgeInsets.only(left: 8), decoration: BoxDecoration(color: const Color(0xFFC4F0FF), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.timer_rounded, color: Colors.black, size: 28))),
            ),
            CustomSlidableAction(
              onPressed: (context) => _showDeleteDialog(context, 'Challenge'),
              backgroundColor: Colors.transparent, padding: EdgeInsets.zero,
              child: Container(margin: const EdgeInsets.only(left: 8), decoration: BoxDecoration(color: const Color(0xFFC92A2A), borderRadius: BorderRadius.circular(12)), child: const Center(child: Icon(Icons.delete_rounded, color: Colors.white, size: 28))),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(color: const Color(0xFF6A594A), borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.star, color: Colors.white)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(value: total == 0 ? 0 : current / total, backgroundColor: Colors.white24, color: const Color(0xFFE6A84A), minHeight: 6),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('$current/$total', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(width: 24, height: 24, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5))),
            ],
          ),
        ),
      ),
    );
  }
}
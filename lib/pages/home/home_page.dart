import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Sesuaikan path import di bawah ini dengan struktur foldermu
import 'package:mino/pages/challenge/widgets/active_challenge_list_page.dart';
import 'package:mino/pages/habit/widgets/active_habit_list_page.dart';
import 'package:mino/pages/home/widgets/todays_progress_card.dart';
import 'widgets/home_header.dart';
import '../../widgets/navbar/bottom_navbar.dart'; 

// Variabel global agar tutorial hanya jalan 1x selama aplikasi hidup
bool _hasShownHabitTutorial = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  // --- FUNGSI POP UP DELETE ---
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
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF1A110A),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png', 
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Panggil Header
                  const HomeHeader(),
                  const SizedBox(height: 24),

                  // 2. Panggil Card Progress Hari Ini
                  const TodaysProgressCard(),
                  const SizedBox(height: 32),

                  // 3. Section Habit (Ditulis Langsung)
                  _buildHabitSection(context),
                  const SizedBox(height: 32),

                  // 4. Section Challenge (Ditulis Langsung)
                  _buildChallengeSection(context),

                  const SizedBox(height: 120), // Spasi aman untuk Bottom NavBar
                ],
              ),
            ),
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
  // SECTION HABIT
  // ===========================================================================
  Widget _buildHabitSection(BuildContext context) {
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

        // CUMA AMBIL 2 ITEM DARI ACTIVE HABIT
        _buildHabitItem(context, '📚', 'Take a deep breath', isTutorial: true),
        _buildHabitItem(context, '🌞', 'Smile for a few seconds'),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(value: 2/7, backgroundColor: Colors.white24, color: Color(0xFFE6A84A), minHeight: 6),
              ),
            ),
            const SizedBox(width: 12),
            const Text('2/7 habits completed', style: TextStyle(color: Color(0xFFE6A84A), fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildHabitItem(BuildContext context, String emoji, String title, {bool isTutorial = false}) {
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
                  Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF4A3A2A), fontWeight: FontWeight.w500))),
                  Container(width: 24, height: 24, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF4A3A2A), width: 1.5))),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION CHALLENGE
  // ===========================================================================
  Widget _buildChallengeSection(BuildContext context) {
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

        // CUMA AMBIL 2 ITEM DARI ACTIVE CHALLENGE
        _buildChallengeItem(context, 'assets/icons/tension.png', 'Release tension in your body', 12, 30),
        _buildChallengeItem(context, 'assets/icons/clean.png', 'Clean your home', 5, 30),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(value: 1/2, backgroundColor: Colors.white24, color: Color(0xFFE6A84A), minHeight: 6),
              ),
            ),
            const SizedBox(width: 12),
            const Text('1/2 challenge completed', style: TextStyle(color: Color(0xFFE6A84A), fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildChallengeItem(BuildContext context, String iconPath, String title, int current, int total) {
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
              const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.star, color: Colors.white)), // Ganti image asset jika ada
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
                            child: LinearProgressIndicator(value: current / total, backgroundColor: Colors.white24, color: const Color(0xFFE6A84A), minHeight: 6),
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
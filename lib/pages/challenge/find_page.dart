import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mino/pages/timer/timer_page.dart';
import 'package:mino/providers/challenge_provider.dart';
import 'package:mino/models/challenge_data.dart';
import '../challenge/challenge_detail_page.dart';
import 'package:mino/pages/timer/widgets/pomodoro_tab_menu.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'package:mino/core/constants/app_colors.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  int _activeTab = 0;

  // Helper fungsi transisi fade tanpa merubah logika apapun
  Route _smoothRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data dari ChallengeProvider
    final challengeProvider = context.watch<ChallengeProvider>();
    final trendingChallenges = challengeProvider.getTrendingChallenges();
    final healthyHabits = challengeProvider.getHealthyHabits();
    final productivityChallenges = challengeProvider.getProductivityChallenges();
    final skincareChallenges = challengeProvider.getSkincareChallenges();

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
              gaplessPlayback: true, 
            ),
          ),

          // Konten Utama dimasukkan ke dalam satu SafeArea & Column
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Judul Find dengan Padding
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 32, right: 25),
                  child: Text(
                    'Find',
                    style: TextStyle(
                      color: AppColors.orange100,
                      fontSize: 28, 
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 2. Menu Tab Pomodoro
                PomodoroTabMenu(
                  selectedIndex: 0,
                  onTabChanged: (index) {
                    if (index == 1) {
                      Navigator.push(
                        context,
                        _smoothRoute(const TimerPage()), 
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),

                // 3. List Konten yang bisa di-scroll
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SECTION 1: TRENDING
                        _buildSectionHeaderWithChip('Trending', 'assets/images/tren.png'),
                        _buildHorizontalChallengeList(trendingChallenges),

                        // SECTION 3: HEALTHY HABITS
                        _buildSectionHeaderText('Healthy habits', 'assets/images/habit.png'),
                        _buildHorizontalChallengeList(healthyHabits),

                        // SECTION 4: PRODUCTIVITY AND LIFESTYLE
                        _buildSectionHeaderText('Productivity and Lifestyle', 'assets/images/watch.png'),
                        _buildHorizontalChallengeList(productivityChallenges),

                        // SECTION 5: SKINCARE & BEAUTY
                        _buildSectionHeaderText('Skincare & Beauty', 'assets/images/skin.png'),
                        _buildHorizontalChallengeList(skincareChallenges),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (i) {},
      ),
    );
  }

  Widget _buildImageAsset(String path, {double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: Colors.white10,
        child: const Icon(Icons.image_not_supported, color: Colors.white54),
      ),
    );
  }

  Widget _buildSectionHeaderWithChip(String title, String fullAssetPath) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 22, bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.06 * 255).toInt()),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withAlpha((0.1 * 255).toInt())),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(fullAssetPath, width: 16, height: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFE2B47E),
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeaderText(String title, String fullAssetPath) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 26, bottom: 12),
      child: Row(
        children: [
          Image.asset(fullAssetPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  // ── 🛠️ SEKARANG SUDAH DINAMIS MENGGUNAKAN DATA PROVIDER ──
  Widget _buildHorizontalChallengeList(List<ChallengeData> items) {
    return SizedBox(
      height: 215, // Kembali ke tinggi semula agar ringkas
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index]; // Mengambil objek item sesuai index-nya dari Provider

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                _smoothRoute(
                  ChallengeDetailPage(
                    challengeId: item.id, // Lempar ID asli dari item yang diklik
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 148,
                  color: Colors.white.withAlpha((0.05 * 255).toInt()),
                  // 🔥 SEKARANG GAMBAR KELUAR DINAMIS SESUAI DATA PROVIDER
                  child: _buildImageAsset(item.imageAsset, fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
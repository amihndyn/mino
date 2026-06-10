import 'package:flutter/material.dart';
import 'package:mino/pages/timer/timer_page.dart';
// Pustaka flutter_svg telah dihapus
import 'package:mino/widgets/appbars/custom_appbar.dart'; 
import '../challenge/challenge_detail_page.dart';
import '../../pages/home/home_page.dart';
import 'package:mino/models/challenge_data.dart';
import 'package:mino/pages/timer/widgets/pomodoro_tab_menu.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Wajib agar background tembus ke bawah navbar
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent, // Wajib agar scaffold transparan
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // CONTENT LAYER
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // HEADER: CustomAppBar
                CustomAppBar(
                  title: 'Find',
                  onBackPressed: () {
                    // Paksa pindah ke HomePage jika tombol back ditekan
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()), 
                      (route) => false,
                    );
                  },
                ),

                const SizedBox(height: 10),

                // 2. KATEGORI TABS ATAS
                PomodoroTabMenu(
  selectedIndex: 0,
  onTabChanged: (index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TimerPage(),
        ),
      );
    }
  },
),

                const SizedBox(height: 8),

                // 3. AREA KONTEN UTAMA (SCROLLABLE)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    // Padding bawah 120 agar konten paling bawah tidak tertutup BottomNavbar
                    padding: const EdgeInsets.only(bottom: 120), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // SECTION 1: TRENDING
                        _buildSectionHeaderWithChip('Trending', 'assets/images/tren.png'),
                        _buildHorizontalChallengeList([
                          ChallengeData(
                            id: 'trend_clean_home',
                            title: 'Benefits of a Clean Home.',
                            imageAsset: 'assets/images/clean.png',
                            detailImageAsset: 'assets/images/cleans.png',
                            description: 'Cleaning your home is not just about neatness, it also has a direct impact on your health and overall comfort. A clean home helps reduce dust, germs, and allergens that can cause illnesses such as coughs, flu, or allergies. In addition, a tidy environment makes your mind feel calmer and more focused, allowing you to be more productive when studying or working. Cleaning activities also count as light physical exercise, which is beneficial for your body, especially when done regularly. Just as important, a clean home creates a comfortable and pleasant atmosphere to live in with your family. So, start making cleaning a regular habit, because the benefits are immediately felt by both your body and mind.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                          ChallengeData(
                            id: 'trend_digital_detox',
                            title: 'Digital detox',
                            imageAsset: 'assets/images/detox.png',
                            detailImageAsset: 'assets/images/detoxs.png',
                            description: 'Take a break from constant notifications and endless scrolling. This challenge helps you reduce screen time and reconnect with the real world around you. By limiting digital distractions, your mind becomes calmer, your focus improves, and you gain more control over how you spend your time. Use this moment to rest your eyes, clear your thoughts, and be more present in your daily life.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                          ChallengeData(
                            id: 'trend_morning_routine',
                            title: 'Morning routine',
                            imageAsset: 'assets/images/routine.png',
                            detailImageAsset: 'assets/images/routines.png',
                            description: 'Start your day with intention and structure. This challenge helps you build a consistent morning routine that sets the tone for the rest of your day. By doing simple activities like planning your tasks, stretching, or enjoying a quiet moment, you create a sense of control and clarity. A good morning routine can boost your productivity, improve your mood, and help you feel more prepared to face the day ahead.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                        ]),

                        // SECTION 2: ROUTINE
                        _buildSectionHeaderWithChip('Routine', 'assets/images/kalender.png'),
                        const SizedBox(height: 10), // Placeholder space jika routine kosong sementara

                        // SECTION 3: HEALTHY HABITS
                        _buildSectionHeaderText('Healthy habits', 'assets/images/habit.png'),
                        _buildHorizontalChallengeList([
                          ChallengeData(
                            id: 'habit_eat_healthy',
                            title: 'Eat Healthy',
                            imageAsset: 'assets/images/eat.png',
                            detailImageAsset: 'assets/images/eats.png',
                            description: 'Fuel your body with the nutrients it needs to function at its best. This challenge encourages you to make healthier food choices and be more mindful of what you eat. A balanced diet supports your energy, focus, and long-term health. Small changes in your eating habits can lead to meaningful results.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                          ChallengeData(
                            id: 'habit_morning_run',
                            title: 'Morning run',
                            imageAsset: 'assets/images/run.png',
                            detailImageAsset: 'assets/images/runs.png',
                            description: 'Start your day with energy and a clear mind through a refreshing morning run. This challenge encourages you to build a healthy routine by moving your body early in the day. Running in the morning helps improve your stamina, boost your mood, and increase your focus for the rest of the day. The fresh air and quiet atmosphere can also give you a sense of calm and motivation. It’s not about speed or distance—it’s about consistency and showing up for yourself.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                          ChallengeData(
                            id: 'habit_drink_8_glasses',
                            title: 'Drink 8 Glasses',
                            imageAsset: 'assets/images/drink.png',
                            detailImageAsset: 'assets/images/drinks.png',
                            description: 'Stay hydrated and take care of your body from within. This challenge helps you build the simple yet powerful habit of drinking enough water every day. Proper hydration supports your energy, focus, and overall health. It may seem small, but consistency in this habit can make a big difference in how you feel daily.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                        ]),

                        // SECTION 4: PRODUCTIVITY AND LIFESTYLE
                        _buildSectionHeaderText('Productivity and Lifestyle', 'assets/images/watch.png'),
                        _buildHorizontalChallengeList([
                          ChallengeData(
                            id: 'prod_no_phone',
                            title: 'No phone before bed',
                            imageAsset: 'assets/images/nophone.png',
                            detailImageAsset: 'assets/images/phones.png',
                            description: 'Give your mind a chance to rest before sleep by staying away from your phone at least 30 minutes before bedtime. Instead of scrolling through social media or watching videos, use this time to relax, read a book, reflect on your day, or prepare for tomorrow. This simple habit can help improve sleep quality, reduce mental fatigue, and create a healthier nighttime routine.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                          ChallengeData(
                            id: 'prod_deep_work',
                            title: 'Deep Work',
                            imageAsset: 'assets/images/deepwork.png',
                            detailImageAsset: 'assets/images/works.png',
                            description: 'Train yourself to work without distractions by dedicating a focused block of time to a single task. Turn off notifications, avoid multitasking, and give your full attention to what matters most. Deep work helps improve concentration, productivity, and the quality of your results while reducing the stress caused by constant interruptions.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                          ChallengeData(
                            id: 'prod_gratitude',
                            title: 'Gratitude Challenge',
                            imageAsset: 'assets/images/gratitude.png',
                            detailImageAsset: 'assets/images/grats.png',
                            description: 'Take a few moments each day to appreciate the good things in your life, no matter how small they may seem. Write down things youre grateful for, meaningful moments, or acts of kindness you experienced. Practicing gratitude helps shift your focus from what is missing to what is already valuable, leading to a more positive mindset and greater emotional well-being.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                        ]),

                        // SECTION 5: SKINCARE & BEAUTY
                        _buildSectionHeaderText('Skincare & Beauty', 'assets/images/skin.png'),
                        _buildHorizontalChallengeList([
                          ChallengeData(
                            id: 'skin_face_yoga',
                            title: 'Face Yoga',
                            imageAsset: 'assets/images/face.png',
                            detailImageAsset: 'assets/images/yogas.png',
                            description: 'Take a moment to care for your skin in a natural and relaxing way. This challenge introduces simple facial exercises that help improve your skin’s health and appearance over time. By gently stimulating your facial muscles, you can boost blood circulation, improve skin elasticity, and reduce signs of aging such as fine lines and wrinkles. Face yoga is not just about beauty—it’s also about relaxation. It helps release tension in your face while giving you a calm and mindful self-care moment. With consistency, your skin will look healthier, brighter, and more radiant.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                          ChallengeData(
                            id: 'skin_skincare',
                            title: 'Skincare Challenge',
                            imageAsset: 'assets/images/skincare.png',
                            detailImageAsset: 'assets/images/skincares.png',
                            description: 'Give your hair the attention it deserves. This challenge focuses on maintaining healthy hair through simple care routines like using treatments or reducing damage. Taking care of your hair regularly helps improve its strength, shine, and overall appearance. Small efforts can make a noticeable difference.',
                            diamondReward: 50,
                            durationDays: 7,
                            dateInfo: 'June 2026',
                          ),
                        ]),
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
        onTap: (i) {
          // isi navigasi sesuai kebutuhan
        },
      ),
    );
  }

  // ==================== IMAGE LOADER VIA ASSETS ====================
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

  // ==================== WIDGET BUILDERS HELPER ====================

  Widget _buildTopTab({required int index, required String label, required String fullAssetPath}) {
    final bool isSelected = _activeTab == index;
    const Color themeGold = Color(0xffF2CD94);

    return GestureDetector(
      onTap: () {
        setState(() => _activeTab = index);
        
        // JIKA TAB TIMER DIKLIK, NAVIGASI KE TIMER PAGE
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TimerPage(),
            ),
          ).then((_) {
            setState(() => _activeTab = 0);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? themeGold.withValues(alpha: 0.8) : Colors.white10,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Opacity(
              opacity: isSelected ? 1.0 : 0.4,
              child: Image.asset(fullAssetPath, width: 18, height: 18), 
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeaderWithChip(String title, String fullAssetPath) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 22, bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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

  Widget _buildHorizontalChallengeList(List<ChallengeData> items) {
    return SizedBox(
      height: 215,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengeDetailPage(
                    challenge: item,
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
                  color: Colors.white.withValues(alpha: 0.05),
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
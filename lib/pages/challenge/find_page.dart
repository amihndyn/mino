import 'package:flutter/material.dart';
import '../challenge/challenge_detail_page.dart';

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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. BACKGROUND UTAMA
          _buildImageAsset(
            'assets/images/bg_login.png', 
            width: double.infinity, 
            height: double.infinity, 
            fit: BoxFit.cover,
          ),

          // CONTENT LAYER
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // HEADER: "< Find"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Find',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. KATEGORI TABS ATAS (Migrasi ke .png)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildTopTab(index: 0, label: 'Challenge', fullAssetPath: 'assets/images/tren.png'),
                        const SizedBox(width: 12),
                        _buildTopTab(index: 1, label: 'Timer', fullAssetPath: 'assets/images/watch.png'),
                        const SizedBox(width: 12),
                        _buildTopTab(index: 2, label: 'Afirmation', fullAssetPath: 'assets/images/plan.png'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // 3. AREA KONTEN UTAMA (SCROLLABLE)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // SECTION 1: TRENDING
                        _buildSectionHeaderWithChip('Trending', 'assets/images/tren.png'),
                        _buildHorizontalChallengeList([
                          {'title': 'Clean your home', 'image': 'assets/images/clean.png', 'desc': 'Create a peaceful environment.'},
                          {'title': 'Digital detox', 'image': 'assets/images/detox.png', 'desc': 'Disconnect from screens.'},
                          {'title': 'Morning routine', 'image': 'assets/images/routine.png', 'desc': 'Start your day intentional.'},
                        ]),

                        // SECTION 2: ROUTINE
                        _buildSectionHeaderWithChip('Routine', 'assets/images/kalender.png'),
                        _buildHorizontalChallengeList([
                          {'title': 'Morning routine', 'image': 'assets/images/routine.png', 'desc': 'Build powerful daily habits.'},
                        ]),

                        // SECTION 3: HEALTHY HABITS
                        _buildSectionHeaderText('Healthy habits', 'assets/images/habit.png'),
                        _buildHorizontalChallengeList([
                          {'title': 'Morning run', 'image': 'assets/images/run.png', 'desc': 'Boost your cardiovascular health.'},
                          {'title': 'Drink 8 Glasses', 'image': 'assets/images/drink.png', 'desc': 'Keep your body fully hydrated.'},
                        ]),

                        // SECTION 4: PRODUCTIVITY AND LIFESTYLE
                        _buildSectionHeaderText('Productivity and Lifestyle', 'assets/images/jam.png'),
                        _buildHorizontalChallengeList([
                          {'title': 'No phone before bed', 'image': 'assets/images/nophone.png', 'desc': 'Improve your sleep quality.'},
                          {'title': 'Gratitude Challenge', 'image': 'assets/images/gratitude.png', 'desc': 'Write down things you are grateful for.'},
                        ]),

                        // SECTION 5: SKINCARE & BEAUTY
                        _buildSectionHeaderText('Skincare & Beauty', 'assets/images/skin.png'),
                        _buildHorizontalChallengeList([
                          {'title': 'Face Yoga', 'image': 'assets/images/face.png', 'desc': 'Natural exercises to tone your facial muscles.'},
                          {'title': 'Skincare Challenge', 'image': 'assets/images/skincare.png', 'desc': 'Maintain consistency in your skincare rituals.'},
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
    );
  }

  // ==================== IMAGE LOADER VIA ASSETS ====================
  // Menggunakan Image.asset standar bawaan Flutter dengan error fallback
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
      onTap: () => setState(() => _activeTab = index),
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
              child: _buildImageAsset(fullAssetPath, width: 18, height: 18),
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
            _buildImageAsset(fullAssetPath, width: 16, height: 16),
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
          _buildImageAsset(fullAssetPath, width: 20, height: 20),
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

  Widget _buildHorizontalChallengeList(List<Map<String, String>> items) {
    return SizedBox(
      height: 215,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final String imagePath = item['image']!;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengeDetailPage(
                    imageAsset: imagePath,
                    title: item['title']!,
                    description: item['desc']!,
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
                  child: _buildImageAsset(imagePath, fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
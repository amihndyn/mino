import 'package:flutter/material.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                CustomAppBar(
                  title: 'Challenges',
                  showBackButton: false,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Active Challenge',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _challengeCard(
                          title: '7 Days Focus Challenge',
                          subtitle:
                              'Stay productive and focused everyday ✨',
                          progress: 0.7,
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          'Recommended',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _challengeCard(
                          title: 'Morning Routine',
                          subtitle:
                              'Build healthy habits every morning 🌞',
                          progress: 0.3,
                        ),

                        const SizedBox(height: 12),

                        _challengeCard(
                          title: 'Reading Challenge',
                          subtitle:
                              'Read at least 10 pages everyday 📚',
                          progress: 0.5,
                        ),

                        const SizedBox(height: 120),
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
      ),
    );
  }

  Widget _challengeCard({
    required String title,
    required String subtitle,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.white12,
          ),
        ],
      ),
    );
  }
}
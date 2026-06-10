import 'package:flutter/material.dart';
import 'package:mino/models/challenge_data.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'package:mino/widgets/button/custom_button.dart';


class ChallengeDetailPage extends StatefulWidget {
  final ChallengeData challenge;

  const ChallengeDetailPage({
    super.key,
    required this.challenge,
  });

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                CustomAppBar(
                  title: widget.challenge.title,
                 
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),

                        /// Banner Challenge
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: _buildChallengeImage(widget.challenge.detailImageAsset),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Reward & Duration Chips (Migrasi ke .png)
                        Row(
                          children: [
                            _buildChip(
                              assetPath: 'assets/images/diamond.png',
                              label: '+${widget.challenge.diamondReward}',
                              textColor: const Color(0xff18C3F7),
                              bgColor: const Color(0xff1A365D).withOpacity(0.6),
                            ),
                            const SizedBox(width: 10),
                            _buildChip(
                              assetPath: 'assets/images/redflag.png',
                              label: '${widget.challenge.durationDays} days',
                              textColor: const Color(0xffFF6B6B),
                              bgColor: const Color(0xff5C251E).withOpacity(0.6),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        /// Date Info
                        Text(
                          widget.challenge.dateInfo,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Title
                        Text(
                          widget.challenge.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// Description
                        Text(
                          widget.challenge.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                children: [
                  /// TOMBOL UTAMA: Add to Routine
                 Expanded(
  child: SizedBox(
    height: 50,
    child: CustomButton(
      text: 'Add to my routine',
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '"${widget.challenge.title}" has been added to your routine!',
            ),
          ),
        );
      },
    ),
  ),
),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
          BottomNavbar(currentIndex: 2),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String assetPath,
    required String label,
    required Color textColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(assetPath, width: 16, height: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeImage(String assetPath) {
  final imagePath = assetPath.isNotEmpty
      ? assetPath
      : widget.challenge.imageAsset;

  return Image.asset(
  imagePath,
  fit: BoxFit.cover,
  alignment: Alignment.topCenter,
);
}
}
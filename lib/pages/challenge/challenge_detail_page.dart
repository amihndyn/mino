import 'package:flutter/material.dart';
import 'package:mino/models/challenge_data.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

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
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.challenge.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xff462F21);
    const Color accentColor = Color(0xffF2CD94);

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
                  onBackPressed: () => Navigator.pop(context),
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
                          height: 233,
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
                            child: _buildChallengeImage(widget.challenge.imageAsset),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Reward & Duration Chips (Migrasi ke .png)
                        Row(
                          children: [
                            _buildChip(
                              assetPath: 'assets/images/berlian.png',
                              label: '+${widget.challenge.diamondReward}',
                              textColor: const Color(0xff18C3F7),
                              bgColor: const Color(0xff1A365D).withOpacity(0.6),
                            ),
                            const SizedBox(width: 10),
                            _buildChip(
                              assetPath: 'assets/images/flag.png',
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
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('"${widget.challenge.title}" has been added to your routine!'),
                            backgroundColor: bgColor,
                          ),
                        );
                      },
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xff2C1B12).withOpacity(0.85),
                              const Color(0xff1C100A).withOpacity(0.95),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: accentColor.withOpacity(0.15),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Add to my routine',
                            style: TextStyle(
                              color: Color(0xffE5C185),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// 🔥 TOMBOL BARU: Add to Favorite
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                        widget.challenge.isFavorite = _isFavorite;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isFavorite 
                              ? 'Added to Favorites!' 
                              : 'Removed from Favorites!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff2C1B12).withOpacity(0.85),
                            const Color(0xff1C100A).withOpacity(0.95),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: accentColor.withOpacity(0.15),
                        ),
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.redAccent : const Color(0xffE5C185),
                        size: 24,
                      ),
                    ),
                  ),
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
    // Jika data model challenge lawas masih mengirimkan ekstensi .svg, jalankan fungsi pembersihan/replace string otomatis ke .png
    final cleanPath = assetPath.toLowerCase().endsWith('.svg')
        ? '${assetPath.substring(0, assetPath.length - 4)}.png'
        : assetPath;

    return Image.asset(
      cleanPath, 
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          color: Color(0xffF2CD94),
          size: 40,
        ),
      ),
    );
  }
}
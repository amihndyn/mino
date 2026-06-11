import 'package:flutter/material.dart';
import 'package:mino/theme/tokens.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/data/provider/profile_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileCard extends StatelessWidget {
  final String avatarPath;
  final VoidCallback onAvatarTap;
  final VoidCallback onEditProfileTap;

  const ProfileCard({
    super.key,
    required this.avatarPath,
    required this.onAvatarTap,
    required this.onEditProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    // Ambil data nama dari provider
    final profile = context.watch<ProfileProvider>().profileData?.user;
    final String displayName = profile?.name ?? 'Miner';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE6A84A),
              Color(0xFFD49940),
              Color(0xFFB3A071),
              Color(0xFF79A6A5),
              Color(0xFF3FA7C4),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AVATAR (Support URL dari API dan local asset)
            GestureDetector(
              onTap: onAvatarTap,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF3E7D7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: _buildAvatarImage(),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // NAMA
            Text(
              displayName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: coklat800,
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: onEditProfileTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF332A26),
                side: const BorderSide(
                  color: Color(0xFF332A26),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk menampilkan avatar (URL atau local asset)
  Widget _buildAvatarImage() {
    // Cek apakah avatarPath adalah URL atau local path
    if (avatarPath.startsWith('http://') || avatarPath.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: avatarPath,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          'assets/images/default.png',
          fit: BoxFit.contain,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/default.png',
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Image.asset(
          avatarPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            'assets/images/default.png',
            fit: BoxFit.contain,
          ),
        ),
      );
    }
  }
}
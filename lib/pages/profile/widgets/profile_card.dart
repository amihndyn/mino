import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mino/providers/profile_provider.dart'; // 🛠️ Pastikan import ini ada

class ProfileCard extends StatelessWidget {
  final String avatarPath;
  final VoidCallback onAvatarTap;

  const ProfileCard({
    super.key,
    required this.avatarPath,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    // 🛠️ Mengambil data profil dari provider untuk nama
    final profile = context.watch<ProfileProvider>().profile;
    final String displayName = profile?.name ?? 'Miner';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
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
          children: [
            const SizedBox(height: 28),

            // AVATAR + CAMERA
            GestureDetector(
              onTap: onAvatarTap,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                 Container(
  width: 140,
  height: 140,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: const Color(0xFFF3E7D7),
    border: Border.all(
      color: Colors.white.withOpacity(0.4),
      width: 2,
    ),
  ),
 child: ClipOval(
  child: Padding(
    padding: const EdgeInsets.all(30),
    child: Image.asset(
      avatarPath,
      fit: BoxFit.contain,
    ),
  ),
),
),
                  Positioned(
  right: 0,
  bottom: 0,
  child: GestureDetector(
    onTap: onAvatarTap,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF2F211D),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Icon(
        Icons.camera_alt_outlined,
        color: Color(0xFFE6A84A),
        size: 22,
      ),
    ),
  ),
),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // NAME
            Text(
              displayName, // 🛠️ Menampilkan nama dari Provider
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F211D),
              ),
            ),

            const SizedBox(height: 16),

            // EDIT BUTTON
            GestureDetector(
              onTap: onAvatarTap, // 🛠️ Tambahkan GestureDetector agar tombol bisa diklik
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A2823),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Color(0xFFE6A84A),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Color(0xFFE6A84A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/data/model/response/profile_response_model.dart';
import 'package:mino/core/data/provider/profile_provider.dart';
import 'package:mino/pages/profile/edit_profile_page.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';

import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'widgets/profile_card.dart';
import 'widgets/profile_stats_section.dart';
import 'choose_avatar_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Memanggil API secara langsung tanpa post-frame callback
    context.read<ProfileProvider>().fetchProfile();
  }

  Future<void> _goToChooseAvatarPage() async {
    final String? result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ChooseAvatarPage(),
    );

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Avatar has changed'),
          backgroundColor: const Color(0xFF3A2823),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // ── Navigasi ke Edit Profile dengan semua data ──
  void _onEditProfileTap() {
    final profileData = context.read<ProfileProvider>().profileData;
    final user = profileData?.user;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          user: UserProfile(
            name: user?.name ?? '',
            email: user?.email ?? '',
            gender: user?.gender,
            ttl: user?.ttl,
            photoUrl: user?.photoUrl,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data dari ProfileProvider
    final profileProvider = context.watch<ProfileProvider>();
    final userData = profileProvider.profileData?.user;

    // Tentukan avatar (dari API atau default)
    String avatarPath = userData?.photoUrl ?? 'assets/images/default.png';
    // Fallback jika photoUrl null atau empty
    if (avatarPath.isEmpty) {
      avatarPath = 'assets/images/default.png';
    }

    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // BACKGROUND (PNG)
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.black),
            ),
          ),

          // CONTENT
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  // ✨ Menggunakan CustomAppBar dari branch Sausan
                  const CustomAppBar(
                    title: 'Profile', 
                    showBackButton: false,
                  ),
                  const SizedBox(height: 20),

                  ProfileCard(
                    avatarPath: avatarPath,
                    onAvatarTap: _goToChooseAvatarPage,
                    onEditProfileTap: _onEditProfileTap,
                  ),

                  const SizedBox(height: 24),

                  // Tampilkan data dari API
                  _buildReadOnlyPillField(
                    text: userData?.name ?? '-',
                    icon: Icons.person_outline,
                  ),
                  _buildReadOnlyPillField(
                    text: userData?.gender ?? '-',
                    imagePath: 'assets/icons/gender.png',
                  ),
                  _buildReadOnlyPillField(
                    text: userData?.ttl ?? '-',
                    icon: Icons.cake_outlined,
                  ),
                  _buildReadOnlyPillField(
                    text: userData?.email ?? '-',
                    icon: Icons.mail_outline,
                  ),

                  const SizedBox(height: 28),

                  // STATS GRID
                  const ProfileStatsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 4,
        onTap: (index) {},
      ),
    );
  }

  // ── 🛠️ WIDGET HELPER READ-ONLY BENTUK OVAL (RATA KIRI DENGAN DYNAMIC ICON) ──
  Widget _buildReadOnlyPillField({
    required String text,
    IconData? icon,
    String? imagePath,
  }) {
    const Color themeGold = Color(0xFFE2AC6B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: themeGold, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Cek apakah pakai imagePath (.png) atau pakai Icon bawaan Flutter
            if (imagePath != null)
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
                color: themeGold,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  color: themeGold,
                  size: 24,
                ),
              )
            else if (icon != null)
              Icon(icon, color: themeGold, size: 24),

            const SizedBox(width: 16), // Jarak antara icon dan teks

            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: themeGold,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
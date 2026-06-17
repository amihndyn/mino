import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/providers/profile_provider.dart';
import 'package:mino/pages/profile/edit_profile_page.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/constants/app_colors.dart'; 

import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'widgets/profile_card.dart';
import 'widgets/profile_stats_section.dart';

// 🔥 IMPORT DASHBOARD BLOC KAMU AGAR BISA DIPANGGIL DI SINI
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart'; 

// ── 🔥 IMPORT POPUP CONFIRMATION CUSTOM KAMU DI SINI ──
import 'package:mino/widgets/popUp/pop_up_info.dart'; 

// Import tambahan untuk fitur Logout
import 'package:mino/core/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:mino/pages/auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // 1. Ambil data identitas profil (Nama, Email, Gender)
        context.read<ProfileProvider>().fetchProfile();

        // 2. 🔥 AMBIL DATA STATISTIK DASHBOARD (Menggunakan bulan berjalan saat ini)
        context.read<DashboardBloc>().add(
              DashboardEvent.fetchDashboardData(month: DateTime.now().month),
            );
      }
    });
  }

  // ── Navigasi ke Edit Profile dengan auto-refresh saat kembali ──
  void _onEditProfileTap() async {
    final user = context.read<ProfileProvider>().profile;

    if (user != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfilePage(user: user),
        ),
      );

      if (result == true && mounted) {
        // 1. Refresh data identitas profil
        context.read<ProfileProvider>().fetchProfile();

        // 2. 🔥 REFRESH DATA STATISTIK GRID
        context.read<DashboardBloc>().add(
              DashboardEvent.fetchDashboardData(month: DateTime.now().month),
            );
      }
    }
  }

  // ── FUNGSIONALITAS DIALOG LOGOUT CUSTOM ──
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return PopUpConfirmation(
          topIcon: const Text('⚠️', style: TextStyle(fontSize: 40)),
          title: "Leave the Mine?",
          description: "Are you sure you want to log out of the app? You'll have to log in again later. ",
          leftButtonText: "Back",
          rightButtonText: "Log Out",
          onLeftTap: () {
            Navigator.pop(dialogContext);
          },
          onRightTap: () async {
            Navigator.pop(dialogContext); 

            context.read<LogoutBloc>().add(const LogoutEvent.logout());

            if (mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color themeGold = Color(0xFFE2AC6B);

    final profileProvider = context.watch<ProfileProvider>();
    final userData = profileProvider.profile;

    // ── LOGIKA PENENTUAN PATH AVATAR YANG AMAN ──
    String avatarPath = 'assets/images/prof.png'; 

    final String? rawAvatar = userData?.avatar.trim();

    if (rawAvatar != null && rawAvatar.isNotEmpty) {
      if (rawAvatar.startsWith('http') || rawAvatar.startsWith('assets/')) {
        avatarPath = rawAvatar;
      } else {
        avatarPath = 'assets/images/$rawAvatar';
      }
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.coklat900,
      body: Stack(
        children: [
          // BACKGROUND (PNG)
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.black),
            ),
          ),

          profileProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFE2AC6B),
                    ),
                  ),
                )
              : profileProvider.errorMessage != null
                  ? Center(
                      child: Text(
                        'Gagal memuat data: ${profileProvider.errorMessage}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  : SafeArea(
                      bottom: false,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          bottom: 140,
                        ), 
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF7EFE7),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            ProfileCard(
                              avatarPath: avatarPath,
                              onAvatarTap: () {},
                              onEditProfileTap: _onEditProfileTap,
                            ),

                            const SizedBox(height: 24),

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

                            // STATS GRID (Sekarang datanya otomatis ter-fetch lewat initState di atas)
                            const ProfileStatsSection(),

                            const SizedBox(height: 5),

                            // ── TOMBOL LOG OUT ──
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: _showLogoutDialog,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.logout, color: themeGold),
                                      SizedBox(width: 12),
                                      Text(
                                        'Log Out',
                                        style: TextStyle(
                                          color: themeGold,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(currentIndex: 3, onTap: (i) {}),
    );
  }

  // ── WIDGET HELPER READ-ONLY BENTUK OVAL ──
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

            const SizedBox(width: 16),

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
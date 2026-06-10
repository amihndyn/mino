import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 🛠️ Tambah import flutter_bloc
import 'package:mino/core/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:mino/pages/auth/login_page.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'widgets/profile_card.dart';
import 'widgets/profile_stats_section.dart';
import 'choose_avatar_page.dart'; 

// ── ⚠️ IMPORT HALAMAN LOGIN KAMU DI SINI ──
// Contoh: import 'package:mino/core/presentation/auth/pages/login_page.dart';
// Silakan hapus komentar dan sesuaikan path-nya agar LoginPage() tidak merah/error.

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedAvatar = 'assets/images/default.png';

  final TextEditingController _nameController = TextEditingController(text: 'Nana');
  final TextEditingController _addressController = TextEditingController(text: 'Jl. Bukittinggi');
  final TextEditingController _phoneController = TextEditingController(text: '+62 890 1234 5678');
  final TextEditingController _emailController = TextEditingController(text: 'nanana.trkj2028@idn.ac.id');

  Future<void> _goToChooseAvatarPage() async {
    final String? result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ChooseAvatarPage(),
    );

    if (result != null) {
      setState(() {
        _selectedAvatar = result;
      });

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

  // ── 🛠️ SOLUSI: DI SINI TEMPAT TARUH FUNGSI LOGOUT DIALOGNYA ──
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF3A2823), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Log Out',
            style: TextStyle(color: Color(0xFFF2D1A2), fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari aplikasi?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog konfirmasi dulu
                // EXECUTE LOGOUT KE BLOC
                context.read<LogoutBloc>().add(const LogoutEvent.logout());
              },
              child: const Text('Ya, Keluar', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFF2D1A2);

    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: accentColor),
              ),
            );
          },
          success: () {
            Navigator.of(context, rootNavigator: true).pop(); // Tutup loading dialog
            
            // ── 🛠️ NAVIGASI LANGSUNG KE CLASS LOGIN PAGE (Anti-Bug) ──
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()), // ⚠️ Pastikan import LoginPage di atas sudah benar
              (route) => false,
            );
          },
          error: (message) {
            Navigator.of(context, rootNavigator: true).pop(); // Tutup loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal Logout: $message'), backgroundColor: Colors.red),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        extendBody: true, 
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
                    const CustomAppBar(title: 'Profile'),
                    const SizedBox(height: 20),

                    ProfileCard(
                      avatarPath: _selectedAvatar,
                      onAvatarTap: _goToChooseAvatarPage,
                    ),

                    const SizedBox(height: 24),

                    // FORM INPUT FIELDS
                    _buildEditableProfileField(
                      icon: Icons.person_outline,
                      label: 'Name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 12),
                    _buildEditableProfileField(
                      icon: Icons.email_outlined,
                      label: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 28),

                    // LOGOUT BUTTON
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: GestureDetector(
                        onTap: () {
                          // PANGGIL DIALOG KONFIRMASI YANG DI ATAS
                          _showLogoutDialog();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.logout, color: accentColor),
                            SizedBox(width: 12),
                            Text(
                              'Log Out',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
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
      ),
    );
  }

  Widget _buildEditableProfileField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    const Color themeGold = Color(0xFFF2D1A2);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: themeGold.withOpacity(0.4), width: 2.2),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          cursorColor: themeGold,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: themeGold.withOpacity(0.7), fontSize: 13, fontWeight: FontWeight.w600),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Icon(icon, color: themeGold, size: 22),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
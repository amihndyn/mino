import 'package:flutter/material.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'widgets/profile_card.dart';
import 'widgets/profile_stats_section.dart';
import 'choose_avatar_page.dart'; // 🛠️ Import halaman choose avatar kamu

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 1. Definisikan avatar default awal
  String _selectedAvatar = 'assets/images/man.png';

  final TextEditingController _nameController = TextEditingController(text: 'Nana');
  final TextEditingController _addressController = TextEditingController(text: 'Jl. Bukittinggi');
  final TextEditingController _phoneController = TextEditingController(text: '+62 890 1234 5678');
  final TextEditingController _emailController = TextEditingController(text: 'nanana.trkj2028@idn.ac.id');

  // 2. Fungsi untuk berpindah halaman dan menangkap avatar baru
  Future<void> _goToChooseAvatarPage() async {
    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const ChooseAvatarPage(),
      ),
    );

    // Jika user memilih avatar (tidak menekan tombol back kosong)
    if (result != null) {
      setState(() {
        _selectedAvatar = result;
      });
    }
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

    return Scaffold(
      backgroundColor: Colors.black,
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  const CustomAppBar(title: 'Profile'),
                  const SizedBox(height: 20),

                  // 3. Pasang variabel avatar dan fungsi tap ke ProfileCard
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
                    child: Row(
                      children: [
                        const Icon(Icons.logout, color: accentColor),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
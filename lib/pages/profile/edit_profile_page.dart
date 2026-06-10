import 'package:flutter/material.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'choose_avatar_page.dart'; // 🛠️ Pastikan import halaman choose avatar kamu
import 'package:mino/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // 1. Inisialisasi Avatar Default awal
  String _selectedAvatar = 'assets/images/default.png';

  // 2. Inisialisasi Controller di dalam State agar tidak me-reset saat diketik
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

 @override
void initState() {
  super.initState();

  _nameController = TextEditingController();
  _emailController = TextEditingController();
  _phoneController = TextEditingController();
  _addressController = TextEditingController();
} 

bool _isLoaded = false;

@override
void didChangeDependencies() {
  super.didChangeDependencies();

  if (!_isLoaded) {
    final profile =
        context.read<ProfileProvider>().profile;

    if (profile != null) {
      _selectedAvatar = profile.avatar;
      _nameController.text = profile.name;
      _emailController.text = profile.email;
    }

    _isLoaded = true;
  }
}

  @override
  void dispose() {
    // Menghapus controller dari memori saat page ditutup
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Fungsi untuk membuka halaman pilih avatar dan menerima hasilnya
  Future<void> _goToChooseAvatarPage() async {
  final String? result =
      await showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const ChooseAvatarPage(),
  );

  if (result != null) {
    setState(() {
      _selectedAvatar = result;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Avatar has changed'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    const Color themeGold = Color(0xFFE6A84A);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // BACKGROUND (PNG)
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.black,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  // APPBAR
                  const CustomAppBar(
                    title: 'Edit Profile',
                  ),

                  const SizedBox(height: 28),

                  // AVATAR (Bisa diketuk untuk ganti foto)
                  GestureDetector(
                    onTap: _goToChooseAvatarPage,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFF3E7D7),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                         child: ClipOval(
  child: Padding(
    padding: const EdgeInsets.all(18),
    child: Image.asset(
      _selectedAvatar,
      fit: BoxFit.contain,
    ),
  ),
),
                        ),
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Color(0xFF2F211D),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: themeGold,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // INPUTS (Menggunakan controller yang stabil)
                  _buildInput(
                    hint: 'Full Name',
                    controller: _nameController,
                  ),

                  const SizedBox(height: 18),

                  _buildInput(
                    hint: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 18),

                  _buildInput(
                    hint: 'Phone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 18),

                  _buildInput(
                    hint: 'Address',
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                  ),

                  const SizedBox(height: 40),

                  // SAVE BUTTON
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () {
                        context.read<ProfileProvider>().updateProfile(
                          name: _nameController.text,
                          email: _emailController.text,
                          avatar: _selectedAvatar,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Avatar has changed',
                                ),
                                backgroundColor: const Color(0xFF3A2823),
                                behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      duration: const Duration(seconds: 2),
    ),
  );

  Navigator.pop(context);
},
                      child: Container(
                        width: double.infinity,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFE6A84A),
                              Color(0xFF3FA7C4),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                              color: Color(0xFF2F211D),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
    );
  }

  // Helper widget input field yang sudah diperbaiki & outline tebal (2.2)
  Widget _buildInput({
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          // 🛠️ PERUBAHAN DI SINI: Outline disesuaikan menjadi tebal (2.2) agar konsisten dengan ProfilePage
          border: Border.all(
            color: const Color(0xFFE6A84A).withValues(alpha: 0.6),
            width: 2.2, 
          ),
          color: Colors.black.withValues(alpha: 0.08),
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Color(0xFFF5D2A5),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: const Color(0xFFE6A84A),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF9F8572),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
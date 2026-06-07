import 'package:flutter/material.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'choose_avatar_page.dart'; // 🛠️ Pastikan import halaman choose avatar kamu

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // 1. Inisialisasi Avatar Default awal
  String _selectedAvatar = 'assets/images/man.png';

  // 2. Inisialisasi Controller di dalam State agar tidak me-reset saat diketik
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Miner');
    _emailController = TextEditingController(text: 'miner@gmail.com');
    _phoneController = TextEditingController(text: '+62 890 1234 5678');
    _addressController = TextEditingController(text: 'Jl. Bukittinggi');
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
    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const ChooseAvatarPage(),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedAvatar = result;
      });
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
                            child: Image.asset(
                              _selectedAvatar,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.person,
                                size: 58,
                                color: Color(0xFFB98A45),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
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
                        // Tambahkan fungsi aksi simpan perubahan di sini
                        // Contoh membawa data kembali ke halaman profil:
                        // Navigator.pop(context);
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
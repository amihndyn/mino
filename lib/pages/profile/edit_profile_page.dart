import 'package:flutter/material.dart';
import 'package:mino/core/data/provider/profile_provider.dart';

import 'package:provider/provider.dart';
import 'package:mino/widgets/button/custom_button.dart';

import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/data/model/response/profile_response_model.dart'; // Sesuaikan jika nama kelas model berbeda

class EditProfilePage extends StatefulWidget {
  final UserProfile user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // State & Controllers
  late String _selectedAvatar;
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;

  // State untuk Dropdown Gender
  String? _selectedGender;
  final List<String> _genderOptions = ['Perempuan', 'Laki-laki', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    // 1. Masukkan data dinamis dari 'widget.user' ke dalam controller
    _nameController = TextEditingController(text: widget.user.name ?? '');
    _dobController = TextEditingController(text: widget.user.ttl ?? ''); 
    _emailController = TextEditingController(text: widget.user.email ?? '');

    // 2. Setup Dropdown Gender (Cek apakah valid agar tidak error)
    if (widget.user.gender != null && _genderOptions.contains(widget.user.gender)) {
      _selectedGender = widget.user.gender;
    } else {
      _selectedGender = null; // Biarkan null jika kosong, agar muncul tulisan hint
    }

    // 3. Setup Avatar (Pakai foto dari API jika ada, jika tidak pakai default)
    _selectedAvatar = widget.user.photoUrl ?? 'assets/images/default.png';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onChangeProfilePicture() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Buka galeri/kamera (Fitur segera hadir)'),
        backgroundColor: const Color(0xFF3A2823),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onSaveChanges() async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    // Bungkus inputan user ke dalam Request Model
    final requestData = ProfileRequestModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      gender: _selectedGender,
      ttl: _dobController.text.trim(),
    );

    // Tampilkan loading dialog agar user tahu proses sedang berjalan
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFFE2AC6B)),
      ),
    );

    // Kirim data ke Provider (imagePath diisi null karena fitur kamera belum siap)
    final isSuccess = await profileProvider.updateProfile(requestData, null);

    // Tutup loading dialog
    if (mounted) Navigator.pop(context);

    // Handling hasil response
    if (isSuccess) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profil berhasil diperbarui!'),
            backgroundColor: Colors.green.shade800,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context); // Kembali ke halaman profil utama
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(profileProvider.errorMessage ?? 'Gagal memperbarui profil'),
            backgroundColor: Colors.red.shade800,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF3A2823),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Log Out',
            style: TextStyle(
              color: Color(0xFFF2D1A2),
              fontWeight: FontWeight.bold,
            ),
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
                Navigator.pop(context);
                // context.read<LogoutBloc>().add(const LogoutEvent.logout());
              },
              child: const Text(
                'Ya, Keluar',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color themeGold = Color(0xFFE2AC6B);
    const Color textDark = Color(0xFF332A26);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.black87),
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
                  const SizedBox(height: 16),

                  // ── CARD ATAS (AVATAR + NAMA + KAMERA) ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      width: double.infinity,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
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
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
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
                                    padding: const EdgeInsets.all(20),
                                    child: Image.asset(
                                      _selectedAvatar,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: _onChangeProfilePicture,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: textDark,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: themeGold,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _nameController.text.isNotEmpty ? _nameController.text : 'User',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── FORM INPUT ──
                  _buildTextField(
                    controller: _nameController,
                    icon: Icons.person_outline,
                    onChanged: (value) {
                      setState(() {}); // Agar nama di atas card berubah live saat diketik
                    },
                  ),

                  // DROPDOWN KHUSUS GENDER
                  _buildDropdownField(
                    value: _selectedGender,
                    imagePath: 'assets/icons/gender.png',
                    items: _genderOptions,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() => _selectedGender = newValue);
                      }
                    },
                  ),

                  _buildTextField(
                    controller: _dobController,
                    icon: Icons.cake_outlined,
                  ),
                  _buildTextField(
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 24),

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
                            const SizedBox(width: 12),
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

                  const SizedBox(height: 40),

                  // ── TOMBOL SAVE CHANGES ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        text: 'Save changes',
                        onTap: _onSaveChanges,
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

  // ── WIDGET HELPER: TEXT FIELD BIASA ──
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    const Color themeGold = Color(0xFFE2AC6B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(
          color: themeGold,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 16),
            child: Icon(icon, color: themeGold, size: 24),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: themeGold, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: themeGold, width: 2.0),
          ),
        ),
      ),
    );
  }

  // ── WIDGET HELPER: DROPDOWN GENDER ──
  Widget _buildDropdownField({
    required String? value,
    required String imagePath,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    const Color themeGold = Color(0xFFE2AC6B);
    const Color menuColor = Color(0xFF332A26); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: menuColor,
        borderRadius: BorderRadius.circular(24),
        elevation: 8, 
        style: const TextStyle(
          color: themeGold,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        icon: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: themeGold,
            size: 28,
          ),
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 16),
            child: Image.asset(
              imagePath,
              width: 24,
              height: 24,
              color: themeGold,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: themeGold, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: themeGold, width: 2.0),
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(item),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mino/providers/profile_provider.dart';
import 'package:mino/models/profile_model.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:mino/widgets/button/custom_button.dart';

import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/constants/app_colors.dart';

// ── 🔥 IMPORT TEMPLATE POPUP KAMU DENGAN BENAR ──
import 'package:mino/widgets/popUp/pop_up_berhasil.dart'; // Sesuaikan folder popup_berhasil.dart
import 'package:mino/widgets/popUp/pop_up_gagal.dart';    // Sesuaikan folder popup_gagal.dart

class EditProfilePage extends StatefulWidget {
  final ProfileModel user;
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
    _nameController = TextEditingController(text: widget.user.name);
    _dobController = TextEditingController(text: widget.user.ttl ?? ''); 
    _emailController = TextEditingController(text: widget.user.email);

    if (widget.user.gender != null && _genderOptions.contains(widget.user.gender)) {
      _selectedGender = widget.user.gender;
    } else {
      _selectedGender = null; 
    }

    _selectedAvatar = widget.user.avatar; 
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ── WIDGET HELPER: ANIMASI SLIDE DOWN DARI ATAS LAYAR ──
  void _showTopNotification(Widget child) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.2), 
      transitionDuration: const Duration(milliseconds: 400), 
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, widgetChild) {
        final tween = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0));
        
        return SlideTransition(
          position: tween.animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutBack)),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Material(
                  color: Colors.transparent,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ── FUNGSI SAVE CHANGES BARU ──
  void _onSaveChanges() async {
    FocusScope.of(context).unfocus(); 

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFFE2AC6B)),
      ),
    );

    String? uploadPath;
    String? avatarValue;

    if (_selectedAvatar.startsWith('assets/images/prof.png')) {
      try {
        final byteData = await rootBundle.load(_selectedAvatar);
        final fileName = _selectedAvatar.split('/').last;
        
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/$fileName');
        
        await tempFile.writeAsBytes(byteData.buffer.asUint8List(
          byteData.offsetInBytes, 
          byteData.lengthInBytes,
        ));
        
        uploadPath = tempFile.path; 
        avatarValue = fileName;
      } catch (e) {
        if (mounted) Navigator.of(context).pop(); 
        _showTopNotification(
          PopUpGagal(
            message: 'Gagal memproses file gambar avatar.',
            onClose: () => Navigator.of(context).pop(), 
          ),
        );
        return;
      }
    } else if (_selectedAvatar.startsWith('http')) {
      uploadPath = null; 
      avatarValue = _selectedAvatar.split('/').last; 
    } else {
      uploadPath = null;
      avatarValue = null;
    }

    final requestData = ProfileRequestModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      gender: _selectedGender,
      ttl: _dobController.text.trim(),
      avatar: avatarValue,
    );

    final isSuccess = await profileProvider.updateProfile(
      requestData,
      uploadPath,
    );

    // Tutup loading dialog
    if (mounted) {
      Navigator.of(context).pop();
    }

    // Handling hasil response
    if (isSuccess) {
      if (mounted) {
        // 🎉 PANGGIL TEMPLATE POPUP BERHASIL YANG PUTIH-HITAM
        _showTopNotification(
          PopUpBerhasil(
            message: "Profile Updated Successfully!",
            onClose: () => Navigator.of(context).pop(), 
          ),
        );

        // Jeda 2 detik agar notif terbaca sebelum kembali
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // Tutup popup di atas jika masih ada
            }
            Navigator.pop(context, true); // Balik ke halaman sebelumnya
          }
        });
      }
    } else {
      if (mounted) {
        // ❌ PANGGIL TEMPLATE POPUP GAGAL YANG PUTIH-HITAM
        _showTopNotification(
          PopUpGagal(
            message: profileProvider.errorMessage ?? 'Gagal memperbarui profil. Coba lagi.',
            onClose: () => Navigator.of(context).pop(), 
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color themeGold = Color(0xFFE2AC6B);
    const Color textDark = Color(0xFF332A26);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.coklat900,
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

                  // ── CARD ATAS (AVATAR STATIS + NAMA) ──
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
                          Container(
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
                              child: Image.asset(
                                _selectedAvatar,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  'assets/images/prof.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                      setState(() {}); 
                    },
                  ),

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
                  
                  // 👇 Bagian Email Field yang sudah disesuaikan
                  _buildTextField(
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true, 
                    onTap: () {
                      // Flag agar pop-up tidak pop dua kali kalau ditutup manual
                      bool isDialogOpen = true; 

                      _showTopNotification(
                        PopUpGagal(
                          message: 'Email address cannot be changed.', // 👈 Bahasa Inggris
                          onClose: () {
                            if (isDialogOpen) {
                              isDialogOpen = false;
                              Navigator.of(context).pop(); 
                            }
                          }, 
                        ),
                      );

                      // 👈 Hilang otomatis dalam 1.5 detik (1500 milidetik)
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        if (mounted && isDialogOpen) {
                          isDialogOpen = false;
                          Navigator.of(context).pop(); 
                        }
                      });
                    },
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

  // WIDGET HELPER
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
    bool readOnly = false, 
    VoidCallback? onTap,
  }) {
    const Color themeGold = Color(0xFFE2AC6B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly, 
        onTap: onTap,       
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
              child: Text(
                item,
                style: const TextStyle(color: themeGold),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
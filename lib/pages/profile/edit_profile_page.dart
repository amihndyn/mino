import 'package:flutter/material.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          // BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(bottom: 40),

              child: Column(
                children: [

                  // APPBAR
                  const CustomAppBar(
                    title: 'Edit Profile',
                  ),

                  const SizedBox(height: 28),

                  // AVATAR
                  Stack(
                    clipBehavior: Clip.none,
                    children: [

                      Container(
                        width: 110,
                        height: 110,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              const Color(0xFFF3E7D7),

                          border: Border.all(
                            color: Colors.white
                                .withOpacity(0.3),
                          ),
                        ),

                        child: const Icon(
                          Icons.person,
                          size: 58,
                          color: Color(0xFFB98A45),
                        ),
                      ),

                      Positioned(
                        right: -2,
                        bottom: -2,

                        child: Container(
                          width: 42,
                          height: 42,

                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF2F211D),

                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color:
                                Color(0xFFE6A84A),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // INPUTS
                  buildInput(
                    hint: 'Full Name',
                    value: 'Miner',
                  ),

                  const SizedBox(height: 18),

                  buildInput(
                    hint: 'Email',
                    value:
                        'miner@gmail.com',
                  ),

                  const SizedBox(height: 18),

                  buildInput(
                    hint: 'Phone',
                    value:
                        '+62 890 1234 5678',
                  ),

                  const SizedBox(height: 18),

                  buildInput(
                    hint: 'Address',
                    value:
                        'Jl. Bukittinggi',
                  ),

                  const SizedBox(height: 40),

                  // SAVE BUTTON
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),

                    child: Container(
                      width: double.infinity,
                      height: 58,

                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),

                        gradient:
                            const LinearGradient(
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
                            color:
                                Color(0xFF2F211D),
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w700,
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

  Widget buildInput({
    required String hint,
    required String value,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      child: Container(
        height: 62,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
        ),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color: const Color(0xFFE6A84A),
          ),

          color:
              Colors.black.withOpacity(0.08),
        ),

        child: TextField(
          controller:
              TextEditingController(
            text: value,
          ),

          style: const TextStyle(
            color: Color(0xFFF5D2A5),
          ),

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              color: Color(0xFF9F8572),
            ),

            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
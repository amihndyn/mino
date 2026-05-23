import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Container(
        width: double.infinity,
        height: 272,

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

            const SizedBox(height: 42),

            // AVATAR + CAMERA
            Stack(
              clipBehavior: Clip.none,
              children: [

                Container(
                  width: 96,
                  height: 96,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF3E7D7),

                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),

                  child: const Icon(
                    Icons.person,
                    size: 54,
                    color: Color(0xFFB98A45),
                  ),
                ),

                Positioned(
                  right: -2,
                  bottom: -2,

                  child: Container(
                    width: 38,
                    height: 38,

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
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // NAME
            const Text(
              'Miner',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F211D),
              ),
            ),

            const SizedBox(height: 16),

            // EDIT BUTTON
            Container(
              width: 120,
              height: 40,

              decoration: BoxDecoration(
                color: const Color(0xFF3A2823),
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

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
          ],
        ),
      ),
    );
  }
}
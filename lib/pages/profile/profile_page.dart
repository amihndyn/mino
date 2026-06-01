import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mino/pages/profile/widgets/info_tile.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';

import 'widgets/profile_card.dart';
import 'widgets/profile_stats_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          // BACKGROUND (Diubah ke SVG)
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/background.svg',
              fit: BoxFit.cover,
            ),
          ),

          // CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [

                  // APPBAR
                  const CustomAppBar(
                    title: 'Profile',
                  ),

                  const SizedBox(height: 20),

                  // PROFILE CARD
                  const ProfileCard(),

                  const SizedBox(height: 24),

                  // INFO TILE
                  const ProfileInfoTile(
                    icon: Icons.person_outline,
                    text: 'Nana',
                  ),

                  const SizedBox(height: 12),

                  const ProfileInfoTile(
                    icon: Icons.location_on_outlined,
                    text: 'Jl. Bukittinggi',
                  ),

                  const SizedBox(height: 12),

                  const ProfileInfoTile(
                    icon: Icons.phone_outlined,
                    text: '+62 890 1234 5678',
                  ),

                  const SizedBox(height: 12),

                  const ProfileInfoTile(
                    icon: Icons.email_outlined,
                    text: 'nanana.trkj2028@idn.ac.id',
                  ),

                  const SizedBox(height: 28),

                  // LOGOUT
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Color(0xFFF2D1A2),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: const Color(0xFFF2D1A2),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
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
}
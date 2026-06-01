import 'package:flutter/material.dart';
import 'package:mino/widgets/cards/add_menu_popup.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // Fungsi untuk memunculkan Pop Up Menu dengan animasi yang lebih smooth
  // Fungsi untuk memunculkan Pop Up Menu
  void _showAddMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.6), 
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        // Panggil widget AddMenuPopup dari file yang baru kamu buat!
        return const AddMenuPopup(); 
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          alignment: const Alignment(0.0, 0.8),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xff462F21);
    const Color accentColor = Color(0xffF2CD94);

    return Container(
      color: Colors.transparent,
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // 1. Background utama Bottom Nav (Kotak Coklat)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
            ),
          ),

          // 2. Tombol Plus (Biru) di tengah
          Positioned(
            top: 8,
            child: GestureDetector(
              onTap: () {
                _showAddMenu(context);
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xff18C3F7),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: accentColor,
                    width: 3.5,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: accentColor,
                  size: 38,
                ),
              ),
            ),
          ),

          // 3. Deretan Menu Navigasi
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem(
                  icon: Icons.home_rounded,
                  label: "Today",
                  index: 0,
                  accentColor: accentColor,
                ),
                _buildItem(
                  icon: Icons.list_alt_rounded,
                  label: "Journal",
                  index: 1,
                  accentColor: accentColor,
                ),
                
                const SizedBox(width: 75), // Jarak kosong agar tidak tertutup tombol biru
                
                _buildItem(
                  icon: Icons.flag_rounded,
                  label: "Challenge",
                  index: 2,
                  accentColor: accentColor,
                ),
                _buildItem(
                  icon: Icons.account_circle_rounded,
                  label: "Profile",
                  index: 3,
                  accentColor: accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int index,
    required Color accentColor,
  }) {
    final bool isActive = currentIndex == index;

    final Color itemColor = isActive
        ? accentColor
        : accentColor.withOpacity(0.6);

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: itemColor,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: itemColor,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
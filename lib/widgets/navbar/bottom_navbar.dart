import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
// <<<<<<< HEAD
//   final ValueChanged<int>? onTap;
// =======
  final Function(int) onTap;
// >>>>>>> 25f8fce0a86ee8235e3d2c4627e73019441ff8fc

  const BottomNavbar({
    super.key,
    required this.currentIndex,
// <<<<<<< HEAD
//     this.onTap,
// =======
    required this.onTap,
// >>>>>>> 25f8fce0a86ee8235e3d2c4627e73019441ff8fc
  });

  @override
  Widget build(BuildContext context) {
    // Warna dasar disesuaikan dengan palet pada gambar
    const Color bgColor = Color(0xff462F21); 
    const Color accentColor = Color(0xffF2CD94); 

    return SizedBox(
      height: 100, // Total tinggi ditingkatkan untuk memberi ruang tombol tengah
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. Background utama Bottom Nav
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
          ),

          // 2. Lengkungan (Bump) untuk latar belakang tombol tengah
          Positioned(
            top: 2,
            child: Container(
              width: 86,
              height: 86,
              decoration: const BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 3. Tombol Plus (Biru) di tengah
          Positioned(
            top: 10,
            child: GestureDetector(
              onTap: () {
                // Tambahkan aksi untuk tombol tengah (Plus) di sini
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xff00C4FF), // Biru cyan terang
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

          // 4. Deretan Menu Navigasi
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem(
                  icon: Icons.home_rounded,
                  label: "Today", // Diubah dari Home menjadi Today
                  index: 0,
                  accentColor: accentColor,
                ),
                _buildItem(
                  icon: Icons.list_alt_rounded, // Ikon list/jurnal
                  label: "Journal",
                  index: 1,
                  accentColor: accentColor,
                ),
                
                // Ruang kosong di tengah agar tidak tertutup tombol biru
                const SizedBox(width: 75), 
                
                _buildItem(
                  icon: Icons.flag_rounded, // Ikon bendera
                  label: "Challenge",
                  index: 2,
                  accentColor: accentColor,
                ),
                _buildItem(
                  icon: Icons.account_circle_rounded, // Ikon profil
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
    
    // Warna teks & ikon (Terang saat aktif, sedikit redup saat tidak aktif)
    final Color itemColor = isActive 
        ? accentColor 
        : accentColor.withOpacity(0.6);

    return GestureDetector(
// <<<<<<< HEAD
//       onTap: onTap != null ? () => onTap!(index) : null,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: isActive
//                 ? const Color(0xffE6A84A)
//                 : Colors.white54,
//           ),

//           const SizedBox(height: 6),

//           Text(
//             label,
//             style: TextStyle(
//               color: isActive
//                   ? const Color(0xffE6A84A)
//                   : Colors.white54,

//               fontSize: 12,
//               fontWeight: FontWeight.w500,
// =======
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque, // Agar area di sekitar ikon juga bisa diklik
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: itemColor,
            size: 28,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: itemColor,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: 0.5,
// >>>>>>> 25f8fce0a86ee8235e3d2c4627e73019441ff8fc
            ),
          ),
        ],
      ),
    );
  }
}
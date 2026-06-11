import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  // 🔥 1. Tambahkan parameter variabel untuk menampung jumlah streak dari Laravel
  final int streakCount;

  const StreakCard({
    super.key,
    required this.streakCount, // Wajib diisi saat dipanggil di HomePage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0x33E6A84A), // Warna oranye transparan
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        // 🔥 2. HAPUS kata 'const' di depan array [ ] agar teks angka bisa dinamis
        children: [
          const Icon(
            Icons.local_fire_department,
            color: Color(0xffE6A84A),
          ),
          const SizedBox(width: 6),
          Text(
            "$streakCount", // 🔥 3. Ubah angka statis menjadi dinamis sesuai data user
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold, // Dibuat bold agar lebih terlihat tegas
            ),
          ),
        ],
      ),
    );
  }
}
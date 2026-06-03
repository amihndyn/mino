import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;

  const ChallengeDetailPage({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xff462F21); // Cokelat tua khas Mino
    const Color accentColor = Color(0xffF2CD94); // Emas khas Mino
    const Color actionColor = Color(0xff18C3F7); // Cyan menyala untuk tombol aksi

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // 1. BACKGROUND KRISTAL SEPERTI FIND PAGE
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image_25_1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER BAR: Tombol Back & Judul Kategori
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                      ),
                    ),
                    const Text(
                      'Challenge Detail',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 40), // Penyeimbang posisi teks di tengah
                  ],
                ),
              ),

              // KONTEN YANG BISA DI-SCROLL
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // 2. KARTU POSTER BESAR TANTANGAN
                      Center(
                        child: Container(
                          height: 320,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              imageAsset,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: bgColor,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.image_not_supported, color: accentColor, size: 50),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 3. JUDUL TANTANGAN
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 4. CHIP TARGET INFORMASI (Menggunakan target.png)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/target.png',
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Target: 7 Days Challenge',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 5. DESKRIPSI DETAIL TANTANGAN
                      const Text(
                        'About This Challenge',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          height: 1.6, // Membuat teks lebih enak dibaca (spasi baris)
                        ),
                      ),

                      const SizedBox(height: 100), // Ruang ekstra agar tidak mentok di bawah
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 6. TOMBOL "START CHALLENGE" MELAYANG DI BAWAH
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: GestureDetector(
            onTap: () {
              // Tambahkan logika di laptop Ami ketika user mulai tantangannya
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Let\'s do this! "$title" started.'),
                  backgroundColor: bgColor,
                ),
              );
            },
            child: Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: actionColor,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: actionColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: const Center(
                child: Text(
                  'Start Challenge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
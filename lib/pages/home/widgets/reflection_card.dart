import 'package:flutter/material.dart';
import 'package:mino/pages/mood/mood_page.dart';
import 'package:mino/widgets/button/custom_button.dart';

class ReflectionCard extends StatelessWidget {
  // 🔥 1. Tambahkan status penanda dari Laravel via Bloc apakah hari ini sudah isi mood/refleksi
  final bool isReflectionAdded; 

  const ReflectionCard({
    super.key,
    this.isReflectionAdded = false, // Default-kan ke false jika belum terisi
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBrownColor = Color(0xff422E22);
    const Color cardBorderColor = Color(0xffFFF2D4);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: cardBorderColor.withOpacity(0.6),
          width: 1.5,
        ),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xffFF9D00),
            Color(0xffFFFDFB),
            Color(0xffFFD799),
          ],
        ),
      ),
      child: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔥 2. Judul berubah dinamis sesuai status input
                Text(
                  isReflectionAdded ? "Reflection Added" : "Add Reflection",
                  style: const TextStyle(
                    color: darkBrownColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                
                // 🔥 3. Sub-deskripsi juga ikut berubah dinamis
                Text(
                  isReflectionAdded 
                      ? "Great job tracking your mood today!" 
                      : "How are you feeling today?",
                  style: const TextStyle(
                    color: darkBrownColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 18),

                // 🔥 4. Atur tombol secara kondisional
                SizedBox(
                  width: 140, 
                  height: 33, 
                  child: isReflectionAdded
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle_rounded, color: darkBrownColor, size: 20),
                              SizedBox(width: 6),
                              Text(
                                "Completed",
                                style: TextStyle(
                                  color: darkBrownColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : CustomButton(
                          text: "Add",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MoodPage(),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),

          // RIGHT IMAGE 
          Image.asset(
            'assets/images/reflection.png',
            width: 113,
            height: 93,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              width: 113,
              height: 93,
              child: Icon(
                Icons.sentiment_satisfied_alt,
                size: 64,
                color: darkBrownColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
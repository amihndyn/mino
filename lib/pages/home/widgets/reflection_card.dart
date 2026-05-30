import 'package:flutter/material.dart';
import 'package:mino/pages/journal/journal_page.dart';
import 'package:mino/pages/mood/mood_page.dart';
import 'package:mino/widgets/button/custom_button.dart';

class ReflectionCard extends StatelessWidget {
  const ReflectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    // WARNA
    const Color darkBrownColor =
        Color(0xff422E22);

    const Color cardBorderColor =
        Color(0xffFFF2D4);

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: cardBorderColor.withOpacity(
            0.6,
          ),
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,

              children: [
                const Text(
                  "Add Reflection",

                  style: TextStyle(
                    color: darkBrownColor,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "How are you feeling today?",

                  style: TextStyle(
                    color: darkBrownColor,
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 18),

                // CUSTOM BUTTON
                SizedBox(
                  width: 150,

                  child: CustomButton(
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

            errorBuilder:
                (
                  context,
                  error,
                  stackTrace,
                ) {
                  return const SizedBox(
                    width: 113,
                    height: 93,

                    child: Icon(
                      Icons
                          .sentiment_satisfied_alt,

                      size: 64,
                      color: darkBrownColor,
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }
}
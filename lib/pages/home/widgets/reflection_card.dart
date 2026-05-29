import 'package:flutter/material.dart';

class ReflectionCard extends StatelessWidget {
  const ReflectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),

        gradient: const LinearGradient(
          colors: [
            Color(0xffFF9800),
            Color(0xffFFD799),
          ],
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Reflection",
                  style: TextStyle(
                    color: Color(0xff59463D),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "How are you feeling today?",
                  style: TextStyle(
                    color: Color(0xff59463D),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff59463D),
                  ),
                  onPressed: () {},
                  child: const Text("Add"),
                )
              ],
            ),
          ),

          const SizedBox(width: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "https://picsum.photos/200",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
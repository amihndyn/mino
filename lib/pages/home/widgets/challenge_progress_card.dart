import 'package:flutter/material.dart';

class ChallengeProgressCard
    extends StatelessWidget {
  const ChallengeProgressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0x80E6A84A),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          const Icon(
            Icons.self_improvement,
            size: 40,
            color: Color(0xffE6A84A),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Release tension in your body",
                  style: TextStyle(
                    color: Color(0xffE6A84A),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12),
                        child: const LinearProgressIndicator(
                          value: 0.4,
                          minHeight: 8,
                          backgroundColor:
                              Colors.white24,
                          valueColor:
                              AlwaysStoppedAnimation(
                            Color(0xffFBA944),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      "12/30",
                      style: TextStyle(
                        color: Color(0xffE6A84A),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(width: 12),

          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xffE6A84A),
          ),
        ],
      ),
    );
  }
}
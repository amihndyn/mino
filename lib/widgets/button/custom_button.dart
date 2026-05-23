import 'dart:math';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth.isInfinite
    ? 250.0
    : constraints.maxWidth;

final h = constraints.maxHeight.isInfinite
    ? 60.0
    : constraints.maxHeight;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              /// 🔥 GERAK KANAN-KIRI MULUS (NO JEDA)
              final flowX =
                  sin(_controller.value * 2 * pi) * (w / 2);

              final glow = (sin(_controller.value * 2 * pi) + 1) / 2;
              final glowOpacity = 0.4 + glow * 0.6;

              return Stack(
                alignment: Alignment.center,
                children: [
                  /// OUTER GLOW
                  Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent.withOpacity(0.4),
                          blurRadius: 25,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  /// BASE
                  Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.brown.shade900.withOpacity(0.75),
                      border: Border.all(
                        color: Colors.orangeAccent.withOpacity(0.25),
                        width: 1.2,
                      ),
                    ),
                  ),

                  /// BG GERAK KIRI-KANAN
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Stack(
                      children: [
                        Transform.translate(
                          offset: Offset(flowX, 0),
                          child: SizedBox(
                            width: w * 2,
                            height: h,
                            child: Image.asset(
                              "assets/icons/bg_blur.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /// GLOW KIRI
                        Positioned(
                          left: w * 0.2,
                          top: h * 0.25,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orangeAccent
                                      .withOpacity(glowOpacity),
                                  blurRadius: 30,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// GLOW KANAN
                        Positioned(
                          right: w * 0.2,
                          bottom: h * 0.25,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orangeAccent
                                      .withOpacity(glowOpacity),
                                  blurRadius: 35,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// TEXT
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Color(0xFFFFF6E0),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
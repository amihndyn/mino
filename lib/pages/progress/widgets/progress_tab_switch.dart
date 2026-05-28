import 'package:flutter/material.dart';

class ProgressTabSwitch extends StatelessWidget {
  final bool isLeftSelected;
  final String leftLabel;
  final String rightLabel;
  final ValueChanged<bool> onTabChanged;

  const ProgressTabSwitch({
    Key? key,
    required this.isLeftSelected,
    required this.leftLabel,
    required this.rightLabel,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Lebar total tombol
      height: 48, // Tinggi total tombol
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF332622), // Warna latar belakang tombol (gelap)
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF4A3831), // Warna border luar
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Indikator Emas yang dapat bergeser (Sliding Indicator)
          AnimatedAlign(
            alignment: isLeftSelected ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFC0864B), // Coklat emas terang (Atas)
                      Color(0xFF865120), // Coklat gelap (Bawah)
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFFDCA971).withOpacity(0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Teks Label yang dapat diklik
          Row(
            children: [
              // Tombol Kiri
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(true),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        color: isLeftSelected
                            ? Colors.white
                            : const Color(0xFFB09D8E),
                      ),
                      child: Text(leftLabel),
                    ),
                  ),
                ),
              ),
              
              // Tombol Kanan
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(false),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        color: !isLeftSelected
                            ? Colors.white
                            : const Color(0xFFB09D8E),
                      ),
                      child: Text(rightLabel),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
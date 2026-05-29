import 'package:flutter/material.dart';

class JournalTabSwitch extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const JournalTabSwitch({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF332622),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF4A3831),
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
          // SLIDING INDICATOR DENGAN CUSTOM SHAPE
          AnimatedAlign(
            alignment: selectedIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            // Menggunakan 54% agar ujung lengkungnya menutupi area tengah dengan sempurna
            child: FractionallySizedBox(
              widthFactor: 0.54, 
              heightFactor: 1.0,
              child: CustomPaint(
                painter: _TabIndicatorPainter(isLeft: selectedIndex == 0),
              ),
            ),
          ),

          // TAB BUTTONS
          Row(
            children: [
              // JOURNAL
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(0),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        color: selectedIndex == 0
                            ? Colors.white
                            : const Color(0xFFB09D8E),
                      ),
                      child: const Text('Journal'),
                    ),
                  ),
                ),
              ),

              // PROGRESS
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(1),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        color: selectedIndex == 1
                            ? Colors.white
                            : const Color(0xFFB09D8E),
                      ),
                      child: const Text('Progress'),
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

/// Custom Painter untuk menggambar bentuk miring asimetris ala UI Game
class _TabIndicatorPainter extends CustomPainter {
  final bool isLeft;

  _TabIndicatorPainter({required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final double r = 20.0; // Radius sudut membulat standar

    // Menggambar Jalur (Path) asimetris
    if (isLeft) {
      // Bentuk tab Kiri (Potongan miring di sisi kanan)
      path.moveTo(r, 0);
      path.lineTo(size.width - 24, 0);
      path.quadraticBezierTo(size.width - 16, 0, size.width - 12, 8); // Lengkungan atas
      path.lineTo(size.width - 4, size.height - 8); // Garis miring menurun
      path.quadraticBezierTo(size.width, size.height, size.width - 12, size.height); // Lengkungan bawah
      path.lineTo(r, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - r);
      path.lineTo(0, r);
      path.quadraticBezierTo(0, 0, r, 0);
    } else {
      // Bentuk tab Kanan (Potongan miring di sisi kiri, cerminan dari tab kiri)
      path.moveTo(12, 0);
      path.quadraticBezierTo(0, 0, 4, 8);
      path.lineTo(16, size.height - 8);
      path.quadraticBezierTo(20, size.height, 28, size.height);
      path.lineTo(size.width - r, size.height);
      path.quadraticBezierTo(size.width, size.height, size.width, size.height - r);
      path.lineTo(size.width, r);
      path.quadraticBezierTo(size.width, 0, size.width - r, 0);
    }
    path.close();

    // 1. Gambar Drop Shadow terlebih dahulu agar berada di belakang
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
    canvas.drawPath(path.shift(const Offset(0, 2)), shadowPaint);

    // 2. Gambar Warna Latar Bergradasi (Gradient)
    final fillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFC0864B),
          Color(0xFF865120),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. Gambar Border Emas (Stroke luar)
    final borderPaint = Paint()
      ..color = const Color(0xFFDCA971).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _TabIndicatorPainter oldDelegate) {
    return oldDelegate.isLeft != isLeft;
  }
}
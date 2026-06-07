import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class JournalTabSwitch extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const JournalTabSwitch({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<JournalTabSwitch> createState() => _JournalTabSwitchState();
}

class _JournalTabSwitchState extends State<JournalTabSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Durasi transisi yang pas & luwes
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    ));

    if (widget.selectedIndex == 1) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(JournalTabSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      if (widget.selectedIndex == 1) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.coklat800, // Background gelap dasar
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: AppColors.coklat700,
          width: 5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // LAYER 1: BACKGOUND GRADASI DAN GARIS PUTIH YANG TETAP UTUH DI KEDUA SISI
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _MorphingTabPainter(
                    progress: _slideAnimation.value,
                    gradientColors: [
                      const Color(0xFF9E6B36), // Gradasi atas tembaga
                      const Color(0xFF704823), // Gradasi bawah
                    ],
                    highlightColor: Color(0xFFC69451), // Garis putih tipis mido
                  ),
                );
              },
            ),
          ),

          // LAYER 2: TOMBOL TEKS INTERFACE (AMAN DARI BUG RENDER)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                final journalColor = Color.lerp(
                  const Color(0xFFFFF1E6),
                  const Color(0xFFFFF1E6).withAlpha((0.35 * 255).round()),
                  _slideAnimation.value,
                )!;

                final progressColor = Color.lerp(
                  const Color(0xFFFFF1E6).withAlpha((0.35 * 255).round()),
                  const Color(0xFFFFF1E6),
                  _slideAnimation.value,
                )!;

                return Row(
                  children: [
                    _StaticTabButton(
                      label: 'Journal',
                      textColor: journalColor,
                      fontWeight: _slideAnimation.value < 0.5 ? FontWeight.w600 : FontWeight.w400,
                      onTap: () => widget.onChanged(0),
                    ),
                    _StaticTabButton(
                      label: 'Progress',
                      textColor: progressColor,
                      fontWeight: _slideAnimation.value >= 0.5 ? FontWeight.w600 : FontWeight.w400,
                      onTap: () => widget.onChanged(1),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MorphingTabPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;
  final Color highlightColor;

  _MorphingTabPainter({
    required this.progress,
    required this.gradientColors,
    required this.highlightColor,
  });

  double _lerp(double start, double end, double t) => start + (end - start) * t;

  @override
  void paint(Canvas canvas, Size size) {
    final double padding = 2.5; 
    final double h = size.height - (padding * 2);
    final double w = size.width - (padding * 2);
    final double r = h / 2; 
    const double kappa = 0.552284749831; 

    // Perbaikan utama: Mengontrol titik tengah pembatas agar saat progress = 1.0 (Progress), 
    // ia tidak menciut habis menjadi 0 melainkan membentuk sisi kanan tab secara utuh.
    final double midX = _lerp(w * 0.52, w * 0.48, progress); 
    const double waveWidth = 14.0; 

    // --- LOGIKA FORMULA KOORDINAT SELEKSI (KIRI KE KANAN) ---
    // Sisi Kiri dinonaktifkan meluncur penuh ke kanan, melainkan bertransformasi posisi objek secara absolut
    final double startLeftTop = padding + r;
    final double endLeftTop = midX - waveWidth;
    final double currentLeftTop = _lerp(startLeftTop, midX + waveWidth, progress);

    final double startLeftBottom = padding + r;
    final double endLeftBottom = midX + waveWidth;
    final double currentLeftBottom = _lerp(startLeftBottom, midX - waveWidth, progress);

    // Titik Sisi Kiri Vektor
    final Offset leftTop = Offset(_lerp(padding + r, midX - waveWidth, progress), padding);
    final Offset leftBottom = Offset(_lerp(padding + r, midX + waveWidth, progress), padding + h);
    
    // Titik Sisi Kanan Vektor
    final Offset rightTop = Offset(_lerp(midX - waveWidth, w + padding - r, progress), padding);
    final Offset rightBottom = Offset(_lerp(midX + waveWidth, w + padding - r, progress), padding + h);

    // Control points kurva Bézier meliuk s-curve asli kamu
    final Offset leftCp1 = Offset(_lerp(padding + r - (kappa * r), midX + (waveWidth * 0.2), progress), padding + h);
    final Offset leftCp2 = Offset(_lerp(padding + r - (kappa * r), midX - (waveWidth * 0.2), progress), padding);
    final Offset rightCp1 = Offset(_lerp(midX - (waveWidth * 0.2), w + padding - r + (kappa * r), progress), padding);
    final Offset rightCp2 = Offset(_lerp(midX + (waveWidth * 0.2), w + padding - r + (kappa * r), progress), padding + h);

    Path path = Path();
    
    // Menggambar ulang struktur Path gabungan kontinu agar area penampung isi tidak nol (0) di frame akhir
    if (progress <= 0.5) {
      path.moveTo(padding + r, padding);
      path.lineTo(rightTop.dx, rightTop.dy);
      path.cubicTo(rightCp1.dx, rightCp1.dy, rightCp2.dx, rightCp2.dy, rightBottom.dx, rightBottom.dy);
      path.lineTo(padding + r, padding + h);
      path.cubicTo(leftCp1.dx, leftCp1.dy, leftCp2.dx, leftCp2.dy, padding + r, padding);
    } else {
      path.moveTo(leftTop.dx, leftTop.dy);
      path.lineTo(w + padding - r, padding);
      path.cubicTo(rightCp1.dx, rightCp1.dy, rightCp2.dx, rightCp2.dy, w + padding - r, padding + h);
      path.lineTo(leftBottom.dx, leftBottom.dy);
      path.cubicTo(leftCp1.dx, leftCp1.dy, leftCp2.dx, leftCp2.dy, leftTop.dx, leftTop.dy);
    }
    
    path.close();

    // --- DRAWING BG GRADASI ---
    final Rect bounds = Rect.fromLTWH(padding, padding, w, h);
    final Paint paintFill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ).createShader(bounds)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paintFill);

    // --- DRAWING LINE PUTIH TIPIS ---
    final Paint paintBorder = Paint()
      ..color = highlightColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
      
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(covariant _MorphingTabPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _StaticTabButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final FontWeight fontWeight;
  final VoidCallback onTap;

  const _StaticTabButton({
    required this.label,
    required this.textColor,
    required this.fontWeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: fontWeight,
              color: textColor,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
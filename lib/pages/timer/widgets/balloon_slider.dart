import 'package:flutter/material.dart';

class BalloonSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const BalloonSlider({
    super.key,
    this.initialValue = 10,
    required this.onChanged,
  });

  @override
  State<BalloonSlider> createState() => _BalloonSliderState();
}

class _BalloonSliderState extends State<BalloonSlider> {
  late double _targetValue;

  @override
  void initState() {
    super.initState();
    _targetValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    const double thumbRadius = 10.0;
    const double balloonWidth = 38.0;
    const double min = 0;
    const double max = 60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔥 TWEEN ANIMATION BUILDER: Membuat pergeseran nilai menjadi lambat & halus
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: _targetValue, end: _targetValue),
            // Jalur kelambatan animasi. 300 milidetik biasanya pas untuk efek smooth.
            // Jika ingin LEBIH LAMBAT lagi, naikkan angkanya (misal: 500 atau 600).
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic, // Efek melambat di akhir geseran
            builder: (context, animatedValue, child) {
              
              return LayoutBuilder(
                builder: (context, constraints) {
                  // Gunakan animatedValue (nilai yang sudah dihaluskan), bukan _targetValue langsung
                  final double percentage = ((animatedValue - min) / (max - min)).clamp(0.0, 1.0);

                  final double startX = thumbRadius;
                  final double endX = constraints.maxWidth - thumbRadius;
                  final double thumbCenterX = startX + (percentage * (endX - startX));
                  final double leftOffset = thumbCenterX - (balloonWidth / 2);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // 1. Slider Custom
                      SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: const Color(0xFFE8A838),
                          inactiveTrackColor: const Color(0xFFE8A838).withValues(alpha: 0.3),
                          thumbColor: const Color(0xFFE8A838),
                          trackHeight: 6,
                          overlayColor: const Color(0xFFE8A838).withValues(alpha: 0.2),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: thumbRadius,
                          ),
                          trackShape: const RectangularSliderTrackShape(),
                        ),
                        child: Slider(
                          // Slider tetap menampilkan posisi jari asli biar tidak delay parah saat di-drag
                          value: _targetValue,
                          min: min,
                          max: max,
                          divisions: 60,
                          onChanged: (val) {
                            setState(() {
                              _targetValue = val;
                            });
                            // Callback ke halaman utama menggunakan nilai yang dibulatkan
                            widget.onChanged(val);
                          },
                        ),
                      ),

                      // 2. Balon Indikator yang Bergerak Lambat & Smooth
                      Positioned(
                        top: -32,
                        left: leftOffset,
                        child: SizedBox(
                          width: balloonWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7EAD3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  // Angka di balon ikut beranimasi naik/turun dengan smooth
                                  animatedValue.round().toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF423125),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              // Segitiga kecil
                              Transform.translate(
                                offset: const Offset(0, -3),
                                child: Transform.rotate(
                                  angle: 45 * 3.1415927 / 180,
                                  child: Container(
                                    width: 7,
                                    height: 7,
                                    color: const Color(0xFFF7EAD3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
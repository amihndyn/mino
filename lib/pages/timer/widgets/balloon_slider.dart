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
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Balon Tooltip & Slider dibungkus Stack agar menyatu
          LayoutBuilder(
            builder: (context, constraints) {
              // Menghitung posisi X untuk balon teks agar ikut thumb slider
              final double min = 0;
              final double max = 60; // Maksimal menit misalnya 60
              final double percentage = (_currentValue - min) / (max - min);
              // Dikurangi sedikit offset agar panahnya pas di tengah thumb
              final double activeWidth = constraints.maxWidth;
              final double leftOffset = percentage * activeWidth - 16; 

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Slider Bawaan yang di-custom warnanya
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: const Color(0xFFE8A838),
                      inactiveTrackColor: const Color(0xFFE8A838).withValues(alpha: 0.3),
                      thumbColor: const Color(0xFFE8A838),
                      trackHeight: 6,
                      overlayColor: const Color(0xFFE8A838).withValues(alpha: 0.2),
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: _currentValue,
                      min: min,
                      max: max,
                      divisions: 60,
                      onChanged: (val) {
                        setState(() {
                          _currentValue = val;
                        });
                        widget.onChanged(val);
                      },
                    ),
                  ),

                  // Balon Indikator Angka (Tooltip)
                  Positioned(
                    top: -30,
                    left: leftOffset.clamp(0, activeWidth - 30), // Mencegah balon keluar layar
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7EAD3), // Warna krem kertas
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _currentValue.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xFF423125),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // Segitiga kecil ke bawah
                        Transform.translate(
                          offset: const Offset(0, -2),
                          child: Transform.rotate(
                            angle: 45 * 3.1415927 / 180,
                            child: Container(
                              width: 8,
                              height: 8,
                              color: const Color(0xFFF7EAD3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
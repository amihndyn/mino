import 'dart:async';
import 'dart:math'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/core/presentation/home/bloc/focus_timer/focus_timer_bloc.dart';
import 'package:mino/pages/timer/finish_timer_page.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/providers/profile_provider.dart';
import 'package:mino/widgets/popUp/pop_up_info.dart';
import 'package:mino/core/constants/app_colors.dart';

class RunningTimerPage extends StatefulWidget {
  final int minutes;
  // ── 🛠️ FIX: Kembalikan tipe data menjadi non-nullable int agar wajib membawa ID transaksi valid
  final int timerId; 

  const RunningTimerPage({
    super.key,
    required this.minutes,
    required this.timerId, // ── 🛠️ FIX: Kembalikan kata kunci required
  });

  @override
  State<RunningTimerPage> createState() => _RunningTimerPageState();
}

class _RunningTimerPageState extends State<RunningTimerPage>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late int _totalSeconds;
  late int _remainingSeconds;

  late final AnimationController _glowController;

  final List<String> _imagePaths = [
    'assets/images/satu.svg',
    'assets/images/dua.svg',
    'assets/images/tiga.svg',
    'assets/images/empat.svg',
    'assets/images/lima.svg',
    'assets/images/enam.svg',
  ];

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.minutes * 60;
    _remainingSeconds = _totalSeconds;

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();

        // ── 🛠️ FIX: Tidak perlu pengecekan null lagi, langsung lempar data aslinya ke BLoC
        context.read<FocusTimerBloc>().add(
              FocusTimerEvent.completeFocus(
                timerId: widget.timerId,
                durationMinutes: widget.minutes,
              ),
            );
      }
    });
  }

  Widget _buildGlowCircle() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE8A838).withOpacity(0.5), 
            blurRadius: 40,
            spreadRadius: 15, 
          ),
        ],
      ),
    );
  }

  Future<void> _showExitConfirmationDialog() async {
    _timer?.cancel();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return PopUpConfirmation(
          title: 'Leave Focus Session?',
          description: 'If you leave now, 3 diamonds will\nbe deducted.',
          leftButtonText: 'Back to home',
          rightButtonText: 'Next',
          
          topIcon: SvgPicture.asset(
            'assets/images/diamond.svg',
            height: 60,
            width: 60,
            placeholderBuilder: (context) => const Icon(
              Icons.diamond, 
              color: Colors.blue, 
              size: 60,
            ),
          ),

          onLeftTap: () {
            Navigator.pop(dialogContext);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },

          onRightTap: () {
            Navigator.pop(dialogContext);
            _startTimer(); 
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _glowController.dispose(); 
    super.dispose();
  }

  String get _formattedTime {
    int m = _remainingSeconds ~/ 60;
    int s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}.${s.toString().padLeft(2, '0')}';
  }

  Widget _buildDynamicImage() {
    int elapsedSeconds = _totalSeconds - _remainingSeconds;

    double interval = _totalSeconds / _imagePaths.length;
    if (interval <= 0) interval = 1;

    int imageIndex = elapsedSeconds ~/ interval;

    if (imageIndex >= _imagePaths.length) {
      imageIndex = _imagePaths.length - 1;
    }

    String currentImage = _imagePaths[imageIndex];
    double imageSize = 480;

    if (currentImage.endsWith('.svg')) {
      return SvgPicture.asset(
        currentImage, 
        height: imageSize,
        width: imageSize,
      );
    } else {
      return Image.asset(
        currentImage, 
        height: imageSize, 
        width: imageSize,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusTimerBloc, FocusTimerState>(
      listener: (context, state) {
        state.maybeWhen(
          completed: () {
            context.read<DashboardBloc>().add(
              const DashboardEvent.fetchDashboardData(),
            );

            context.read<ProfileProvider>().fetchProfile();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FinishTimerPage(completedMinutes: widget.minutes),
              ),
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.coklat900, 
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_login.png',
                fit: BoxFit.cover,
              ),
            ),

            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  AnimatedBuilder(
                    animation: _glowController,
                    builder: (context, child) {
                      final double theta = _glowController.value * 2 * pi;
                      final double radiusX = 80.0; 
                      final double radiusY = 20.0; 

                      final double x1 = sin(theta) * radiusX;
                      final double y1 = cos(theta) * radiusY;

                      final double x2 = sin(theta + pi) * radiusX;
                      final double y2 = cos(theta + pi) * radiusY;

                      return Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none, 
                        children: [
                          Transform.translate(
                            offset: Offset(x1, y1),
                            child: _buildGlowCircle(),
                          ),

                          Transform.translate(
                            offset: Offset(x2, y2),
                            child: _buildGlowCircle(),
                          ),

                          Text(
                            _formattedTime,
                            style: const TextStyle(
                              color: Color(0xFFF7EAD3), 
                              fontSize: 68,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 60),

                  _buildDynamicImage(),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: GestureDetector(
                      onTap: _showExitConfirmationDialog,
                      child: const Text(
                        'Back to home',
                        style: TextStyle(
                          color: Color(0xFFE8A838),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
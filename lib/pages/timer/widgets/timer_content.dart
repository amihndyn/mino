import 'package:flutter/material.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'balloon_slider.dart';

class TimerContent extends StatefulWidget {
  const TimerContent({super.key});

  @override
  State<TimerContent> createState() => _TimerContentState();
}

class _TimerContentState extends State<TimerContent> {
  double _timerValue = 10.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        BalloonSlider(
          initialValue: _timerValue,
          onChanged: (val) => setState(() => _timerValue = val),
        ),
        const SizedBox(height: 60),
        Container(
          width: 250, height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF4A3424), width: 4),
            image: const DecorationImage(
              image: AssetImage('assets/images/crystal_cave.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            width: 200,
            child: CustomButton(
              text: 'Next',
              onTap: () { /* Navigasi ke RunningTimerPage */ },
            ),
          ),
        ),
      ],
    );
  }
}
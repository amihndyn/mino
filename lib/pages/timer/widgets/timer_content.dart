import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/presentation/home/bloc/focus_timer/focus_timer_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'balloon_slider.dart';

class TimerContent extends StatefulWidget {
  // Parameter dari parent (TimerPage) untuk mendeteksi habit yang dipilih
  final int? habitId;
  final String? habitName;

  const TimerContent({super.key, this.habitId, this.habitName});

  @override
  State<TimerContent> createState() => _TimerContentState();
}

class _TimerContentState extends State<TimerContent> {
  double _timerValue = 10.0;
  int? _selectedHabitId;
  String? _selectedHabitName;

  @override
  void initState() {
    super.initState();
    // Kunci data ke state local jika dikirim dari halaman list habit
    _selectedHabitId = widget.habitId;
    _selectedHabitName = widget.habitName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // ── 1. DROPDOWN SELECTION (Paling Atas) ──
        if (widget.habitId == null) 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (response) {
                    final habits = response.dashboard?.todayHabits ?? [];

                    if (habits.isEmpty) {
                      return const Text(
                        "Belum ada habit untuk hari ini.",
                        style: TextStyle(color: Colors.white60),
                      );
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF261912),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE6A84A).withOpacity(0.5)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          dropdownColor: const Color(0xFF261912),
                          hint: const Text(
                            "Pilih Habit / Challenge Anda",
                            style: TextStyle(color: Colors.white60),
                          ),
                          value: _selectedHabitId,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFE6A84A)),
                          items: habits.map((habit) {
                            return DropdownMenuItem<int>(
                              value: habit.userHabitId,
                              child: Text(
                                habit.habitName ?? 'No Title',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              final selectedHabit = habits.firstWhere((h) => h.userHabitId == value);
                              setState(() {
                                _selectedHabitId = value;
                                _selectedHabitName = selectedHabit.habitName;
                              });
                            }
                          },
                        ),
                      ),
                    );
                  },
                  orElse: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFFE6A84A)),
                  ),
                );
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Mengerjakan: ${_selectedHabitName ?? widget.habitName}",
              style: const TextStyle(color: Color(0xFFE6A84A), fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),

        // Jarak dari Dropdown ke Gambar (Bikin gambar agak ke atas)
        const SizedBox(height: 35),

        // ── 2. GAMBAR CRYSTAL CAVE (Sekarang di Tengah Atas) ──
        Container(
          width: 230,
          height: 230,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF4A3424), width: 4),
            image: const DecorationImage(
              image: AssetImage('assets/images/crystal_cave.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Spacer bertugas mendorong Slider dan Button langsung ke area bawah
        const Spacer(),

        // ── 3. WAKTU / TIMER (Sekarang di Bawah Gambar, Dekat Tombol) ──
        BalloonSlider(
          initialValue: _timerValue,
          onChanged: (val) => setState(() => _timerValue = val),
        ),

        const SizedBox(height: 25), // Jarak ideal penengah antara Slider dan Button


      ],
    );
  }
}
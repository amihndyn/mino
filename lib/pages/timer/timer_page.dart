import 'package:flutter/material.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';
import 'package:mino/core/presentation/home/bloc/focus_timer/focus_timer_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/timer/running_timer_page.dart';
import 'package:mino/pages/timer/widgets/pomodoro_tab_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'widgets/balloon_slider.dart';
import 'package:mino/pages/timer/affirmation_page.dart';
import 'package:mino/pages/challenge/find_page.dart';
// 🔥 FIX: Memastikan import pop up konfirmasi/info benar
import 'package:mino/widgets/popUp/pop_up_info.dart'; 
import 'package:mino/core/constants/app_colors.dart';

class TimerPage extends StatefulWidget {
  final int? habitId;
  final String? habitName;

  final int? challengeId;
  final String? challengeName;

  const TimerPage({
    super.key,
    this.habitId,
    this.habitName,
    this.challengeId,
    this.challengeName,
  });

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _selectedTabIndex = 1;
  double _timerValue = 10.0;

  int? _selectedHabitId;
  String? _selectedHabitName;
  int? _selectedChallengeId;
  String? _selectedChallengeName;

  @override
  void initState() {
    super.initState();
    _selectedHabitId = widget.habitId;
    _selectedHabitName = widget.habitName;
    _selectedChallengeId = widget.challengeId;
    _selectedChallengeName = widget.challengeName;
  }

  @override
  Widget build(BuildContext context) {
    bool isAffirmation = _selectedTabIndex == 2;

    return BlocListener<FocusTimerBloc, FocusTimerState>(
      listener: (context, state) {
        state.maybeWhen(
          started: (timerId) {
            // 🔥 FIX UTAMA: Menggunakan Navigator.push biasa agar Context BLoC di atasnya tidak hancur,
            // dan meneruskan `timerId` yang didapat dari state BLoC ke RunningTimerPage.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RunningTimerPage(
                  minutes: _timerValue.toInt(),
                  timerId: timerId, // Ditumpangkan ke parameter RunningTimerPage
                ),
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
            if (isAffirmation)
              AffirmationPage(
                onBack: () {
                  setState(() {
                    _selectedTabIndex = 1;
                  });
                },
              )
            else ...[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomAppBar(
                      title: _selectedHabitName != null
                        ? 'Timer: $_selectedHabitName'
                        : _selectedChallengeName != null
                            ? 'Timer: $_selectedChallengeName'
                            : 'Timer Focus',
                    ),
                    const SizedBox(height: 20),
                    PomodoroTabMenu(
                      selectedIndex: _selectedTabIndex,
                      onTabChanged: (index) {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const FindPage()),
                          );
                          return;
                        }
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                    ),
                    Expanded(child: _buildBodyContent()),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (_selectedTabIndex) {
      case 0:
        return const Center(
          child: Text('Challenge Page', style: TextStyle(color: Colors.white)),
        );
      case 1:
        return Column(
          children: [
            const SizedBox(height: 20),

            // ── 1. DROPDOWN SELECTION ──
            if (widget.habitId == null && widget.challengeId == null) 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      success: (response) {
                        final List<TodayHabit> habits = response.dashboard?.todayHabits ?? [];

                        if (habits.isEmpty) {
                          return const Text(
                            "No habits available for today.",
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
                              menuMaxHeight: 250, 
                              alignment: AlignmentDirectional.centerStart,
                              hint: const Text(
                                "Select your Habit / Challenge",
                                style: TextStyle(color: Colors.white60),
                              ),
                              value: _selectedHabitId,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFE6A84A)),
                              items: habits.map((habit) { 
                                final int id = habit.userHabitId ?? 0;
                                final String name = habit.habitName ?? 'No Title'; 

                                return DropdownMenuItem<int>(
                                  value: id,
                                  child: Text(
                                    name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  final TodayHabit selectedHabit = habits.firstWhere(
                                    (h) => h.userHabitId == value,
                                  );
                                  setState(() {
                                    _selectedHabitId = value;
                                    _selectedHabitName = selectedHabit.habitName; 
                                    _selectedChallengeId = null; 
                                    _selectedChallengeName = null;
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
              ),

            // Flexible spacing
            const Expanded(
              flex: 2, 
              child: SizedBox(),
            ),

            // ── 2. GAMBAR FIXED ──
            Container(
              width: 260, 
              height: 260, 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF4A3424), width: 4),
                image: const DecorationImage(
                  image: AssetImage('assets/images/berlin.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),

            // ── 3. WAKTU / TIMER ──
            BalloonSlider(
              initialValue: _timerValue,
              onChanged: (val) {
                setState(() {
                  _timerValue = val;
                });
              },
            ),
            
            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: 200,
                child: CustomButton(
                  text: 'Next',
                  onTap: () {
                    if (_selectedHabitId == null && _selectedChallengeId == null) {
                      showDialog(
                        context: context,
                        builder: (_) => PopUpConfirmation(
                          title: "Select Item First!",
                          description: "Please select a habit or challenge before starting.",
                          rightButtonText: "OK",
                          isSingleButton: true,
                          topIcon: const Text(
                            "⚠️",
                            style: TextStyle(fontSize: 44),
                          ),
                          onRightTap: () => Navigator.pop(context),
                        ),
                      );
                      return;
                    }

                    context.read<FocusTimerBloc>().add(
                          FocusTimerEvent.startFocus(
                            userHabitId: _selectedHabitId,
                            userChallengeId: _selectedChallengeId,
                          ),
                        );
                  },
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/presentation/home/bloc/reflection/reflection_bloc.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/pages/journal/widgets/monthly_reflection.dart';
import 'package:mino/pages/journal/widgets/period_switcher.dart';
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/note_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/pages/journal/widgets/weekly_reflection.dart';

class JournalPage extends StatefulWidget {
  final int currentTabIndex;
  final ValueChanged<int> onTabChanged;

  const JournalPage({
    super.key,
    required this.currentTabIndex,
    required this.onTabChanged,
  });

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  bool _isWeekly = true;

  // 🔥 FUNGSI UNTUK MERAPIKAN TANGGAL DARI API
  String _formatApiDate(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return "No Date";
    try {
      DateTime parsedDate = DateTime.parse(apiDate);
      return DateFormat("EEEE, d MMMM yyyy").format(parsedDate);
    } catch (e) {
      return apiDate;
    }
  }

  // 🔥 FILTER LOGIC: Menyaring list data jurnal secara lokal (Weekly / Monthly)
  List<dynamic> _filterReflections(List<dynamic> originalList, bool isWeekly) {
    DateTime now = DateTime.now();
    return originalList.where((item) {
      if (item.date == null || item.date.isEmpty) return false;
      try {
        DateTime itemDate = DateTime.parse(item.date);
        if (isWeekly) {
          // Hanya ambil 7 hari terakhir
          return now.difference(itemDate).inDays <= 7;
        } else {
          // Hanya ambil bulan & tahun yang sama dengan saat ini
          return itemDate.month == now.month && itemDate.year == now.year;
        }
      } catch (_) {
        return true; 
      }
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReflectionBloc>().add(
        const ReflectionEvent.getReflections(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Nama bulan otomatis disingkat 3 huruf (contoh: "Jun", "Jul", "Sep") mengikuti tanggal sekarang
    String currentMonthName = DateFormat("MMM").format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================================
        // 1. BAGIAN ATAS (FIXED / TIDAK IKUT SCROLL)
        // ==========================================
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Journal',
                style: TextStyle(
                  color: AppColors.orange100,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: AppSizes.md),

              JournalTabSwitch(
                selectedIndex: widget.currentTabIndex,
                onChanged: widget.onTabChanged,
              ),
              const SizedBox(height: 26),

              PeriodSwitcher(
                isWeekly: _isWeekly,
                onChanged: (val) {
                  setState(() {
                    _isWeekly = val;
                  });
                },
              ),
            ],
          ),
        ),

        // ==========================================
        // 2. BAGIAN BAWAH (SCROLLABLE LIST)
        // ==========================================
        Expanded(
          child: ClipRect(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.md),

                  BlocBuilder<ReflectionBloc, ReflectionState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: CircularProgressIndicator(color: AppColors.orange400),
                          ),
                        ),

                        loaded: (reflections) {
                          // 🔥 List otomatis disaring berdasarkan filter switcher
                          final filteredList = _filterReflections(reflections, _isWeekly);

                          if (filteredList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                child: Text(
                                  _isWeekly 
                                      ? 'No journal entries found for this week.' 
                                      : 'No journal entries found for this month.',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. LIST UTAMA JURNAL
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: filteredList.length,
                                separatorBuilder: (context, index) => const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  final reflection = filteredList[index];

                                  final String moodString = reflection.mood?.toLowerCase() ?? "good";
                                  String emoji = 'assets/images/good.png';
                                  String label = "Good";

                                  if (moodString == 'amazing') {
                                    emoji = 'assets/images/amazing.png';
                                    label = "Amazing";
                                  } else if (moodString == 'good') {
                                    emoji = 'assets/images/good.png';
                                    label = "Good";
                                  } else if (moodString == 'okey' || moodString == 'neutral') {
                                    emoji = 'assets/images/okey.png';
                                    label = "Okey";
                                  } else if (moodString == 'unusual') {
                                    emoji = 'assets/images/unusual.png';
                                    label = "Unusual";
                                  } else if (moodString == 'bad') {
                                    emoji = 'assets/images/bad.png';
                                    label = "Bad";
                                  }

                                  final String formattedDate = _formatApiDate(reflection.date);

                                  return JournalCard(
                                    entry: reflection,
                                    onSeeNote: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NoteDetailPage(
                                            noteTitle: reflection.title ?? "Untitled",
                                            noteContent: reflection.content ?? "",
                                            fullDate: formattedDate,
                                            mood: emoji,
                                            moodLabel: label,
                                            moodColor: AppColors.orange300,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              const SizedBox(height: 24),
                              
                              // 2. KARTU REFLEKSI DI BAGIAN BAWAH
                              if (_isWeekly)
                                const WeeklyReflection()
                              else
                                MonthlyReflection(
                                  selectedMonth: currentMonthName, // 🟢 Menggunakan nama singkat dinamis
                                ),
                            ],
                          );
                        },

                        error: (message) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'Error: $message',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),

                        orElse: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'No journal entries today.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
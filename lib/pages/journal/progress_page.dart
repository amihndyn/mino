// ============================================
// PROGRESS PAGE
// ============================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:mino/pages/journal/journal_page.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 1; 
    int _navIndex = 1;// Start with "Progress" selected
  bool _isWeekly = true;
  String _selectedMonth = 'May 2026';

  final List<_MonthData> _monthlyData = [
    _MonthData(
      month: 'May 2026',
      goalPercent: 0.84,
      weeklyBars: [3.2, 2.8, 3.5, 2.0],
    ),
    _MonthData(
      month: 'April 2026',
      goalPercent: 0.72,
      weeklyBars: [2.5, 3.0, 2.8, 3.2],
    ),
    _MonthData(
      month: 'March 2026',
      goalPercent: 0.65,
      weeklyBars: [2.0, 2.2, 2.5, 2.8],
    ),
    _MonthData(
      month: 'February 2026',
      goalPercent: 0.50,
      weeklyBars: [1.5, 2.0, 2.2, 2.5],
    ),
    _MonthData(
      month: 'January 2026',
      goalPercent: 0.45,
      weeklyBars: [1.0, 1.2, 1.5, 1.8],
    ),
    _MonthData(
      month: 'December 2025',
      goalPercent: 0.30,
      weeklyBars: [0.8, 1.0, 1.2, 1.5],
    ),
  ];

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  _MonthData get _currentMonthData =>
      _monthlyData.firstWhere((d) => d.month == _selectedMonth);

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _MonthPickerSheet(
        selectedMonth: _selectedMonth,
        months: _monthlyData.map((d) => d.month).toList(),
        onSelected: (month) {
          setState(() => _selectedMonth = month);
          _animCtrl.forward(from: 0);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // BACKGROUND
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          // CONTENT
          SafeArea(
            child: Column(
              children: [
                // APPBAR
                CustomAppBar(title: 'Progress'),

                // SCROLLABLE CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSizes.md),

                        // JOURNAL / PROGRESS TAB SWITCH
                        JournalTabSwitch(
                          selectedIndex: _tabIndex,
                          onChanged: (index) {
                            if (index == 0) {
                              Navigator.pop(context);
                            } else {
                              setState(() => _tabIndex = index);
                            }
                          },
                        ),

                        const SizedBox(height: 26),

                        // WEEKLY / MONTHLY SWITCHER
                        _buildPeriodSwitcher(),

                        const SizedBox(height: 26),

                        // GOAL CARD
                        _buildGoalCard(),

                        const SizedBox(height: 26),

                        // ACTIVITY CARD
                        _buildActivityCard(),

                        const SizedBox(height: 26),

                        // STATS GRID (NEW)
                        _buildStatsGrid(),

                        const SizedBox(height: 26),

                        // WEEKLY ACHIEVEMENTS (NEW)
                        _buildWeeklyAchievements(),

                        const SizedBox(height: 26),

                        // WEEKLY REFLECTION (NEW)
                        _buildWeeklyReflection(),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
      currentIndex: _navIndex,
      onTap: (i) => setState(() => _navIndex = i),
    ),
    );
  }

  Widget _buildPeriodSwitcher() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isWeekly = true),
                child: Column(
                  children: [
                    Text(
                      'Weekly',
                      style: TextStyle(
                        color: _isWeekly
                            ? AppColors.orange100
                            : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      width: double.infinity,
                      color: _isWeekly
                          ? AppColors.orange500
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isWeekly = false),
                child: Column(
                  children: [
                    Text(
                      'Monthly',
                      style: TextStyle(
                        color: !_isWeekly
                            ? AppColors.orange100
                            : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      width: double.infinity,
                      color: !_isWeekly
                          ? AppColors.orange500
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(height: 1, color: AppColors.coklat600),
      ],
    );
  }

  Widget _buildGoalCard() {
    final data = _isWeekly
        ? _MonthData(month: 'This Week', goalPercent: 0.84, weeklyBars: [])
        : _currentMonthData;
    final percentLabel = '${(data.goalPercent * 100).toInt()}%';

    // 🌟 BUNGKUS DENGAN CONTAINER UNTUK MEMBERIKAN SHADOW
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange700.withValues(
              alpha: 0.15,
            ), // Efek glow orange halus melingkar
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.coklat900.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: AppColors.orange900.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isWeekly ? 'Weekly Goal' : 'Monthly Goal',
                        style: TextStyle(
                          color: AppColors.coklat300,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "You're getting\ncloser to your\ndiamond.",
                        style: TextStyle(
                          color: AppColors.orange700,
                          fontSize: 18,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 42,
                  lineWidth: 8,
                  percent: data.goalPercent,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppColors.orange300,
                  backgroundColor: AppColors.orange900.withValues(alpha: 0.25),
                  center: Text(
                    percentLabel,
                    style: TextStyle(
                      color: AppColors.orange700,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard() {
    final weeklyData = [2.2, 1.8, 0.9, 2.0, 1.5, 2.2, 2.2];
    final data = _isWeekly ? null : _currentMonthData;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppColors.orange700.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isWeekly ? 'Weekly Activity' : 'Monthly Activity',
                          style: TextStyle(
                            color: AppColors.orange100,
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isWeekly
                              ? 'Your habit consistency\nthis week'
                              : 'Your habit consistency\nin $_selectedMonth',
                          style: TextStyle(
                            color: AppColors.orange800,
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // MONTH DROPDOWN (only for Monthly view)
                  if (!_isWeekly)
                    GestureDetector(
                      onTap: _showMonthPicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.coklat800.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.orange700.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _selectedMonth,
                              style: TextStyle(
                                color: AppColors.orange100,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.orange300,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 220,
                child: _isWeekly
                    ? _buildWeeklyChart(weeklyData)
                    : _buildMonthlyChart(data!.weeklyBars),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(List<double> weeklyData) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
    final yAxisLabels = ['4', '3', '2', '1', '0'];

    // Gunakan IntrinsicHeight agar tinggi Column angka mengikuti tinggi total grafik di kanannya
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🌟 INDIKATOR ANGKA DI SEBELAH KIRI
          Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Ini akan memaksa angka 0 berada di paling bawah
            crossAxisAlignment: CrossAxisAlignment.end,
            children: yAxisLabels.map((label) {
              return Text(
                label,
                style: TextStyle(
                  color: AppColors.coklat300,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),

          // Jarak horizontal antara kolom angka dan grafik batang
          const SizedBox(width: 16),

          // 🌟 GRAFIK BATANG UTAMA
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                weeklyData.length,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 28,
                      height: weeklyData[index] * 40,
                      decoration: BoxDecoration(
                        color: AppColors.orange800,

                        // 🌟 UBAH DI SINI: Hanya rounded di bagian atas (top)
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(7),
                        ),
                      ),
                    ),
                    // Jarak antara batang dan tulisan hari
                    const SizedBox(height: 10),
                    Text(
                      days[index],
                      style: TextStyle(
                        color: AppColors.orange100,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart(List<double> barData) {
  final days = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6', 'Week 7'];
    final yAxisLabels = ['4', '3', '2', '1', '0'];

    // Gunakan IntrinsicHeight agar tinggi Column angka mengikuti tinggi total grafik di kanannya
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🌟 INDIKATOR ANGKA DI SEBELAH KIRI
          Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Ini akan memaksa angka 0 berada di paling bawah
            crossAxisAlignment: CrossAxisAlignment.end,
            children: yAxisLabels.map((label) {
              return Text(
                label,
                style: TextStyle(
                  color: AppColors.coklat300,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),

          // Jarak horizontal antara kolom angka dan grafik batang
          const SizedBox(width: 16),

          // 🌟 GRAFIK BATANG UTAMA
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                barData.length,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 50,
                      height: barData[index] * 40,
                      decoration: BoxDecoration(
                        color: AppColors.orange800,

                        // 🌟 UBAH DI SINI: Hanya rounded di bagian atas (top)
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(7),
                        ),
                      ),
                    ),
                    // Jarak antara batang dan tulisan hari
                    const SizedBox(height: 10),
                    Text(
                      days[index],
                      style: TextStyle(
                        color: AppColors.orange100,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================
  // NEW: STATS GRID
  // =========================================

Widget _buildStatsGrid() {
  final stats = [
    _StatData(
      label: 'Habits Completed',
      value: '128',
      icon: Icons.track_changes_rounded, // Menggantikan icon target/bullseye
    ),
    _StatData(
      label: 'Focus Hours',
      value: '42h',
      icon: Icons.emoji_events_rounded, // Icon piala
    ),
    _StatData(
      label: 'Challenge completed', // Dihapus \n nya karena space sudah otomatis nge-wrap lewat Text widget jika kurang
      value: '21 Days',
      icon: Icons.diamond_rounded, // Icon diamond
    ),
    _StatData(
      label: 'Diamonds Earned',
      value: '16',
      icon: Icons.diamond_rounded, // Icon diamond
    ),
  ];

  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 16, // Sedikit diperlebar agar seimbang dengan gambar
    mainAxisSpacing: 16,
    childAspectRatio: 1.4, // Rasio disesuaikan agar card terlihat persegi panjang pas
    children: stats.map((stat) => _buildStatCard(stat)).toList(),
  );
}

Widget _buildStatCard(_StatData stat) {
  return Container(
    // Padding bagian dalam card dibuat seimbang
    padding: const EdgeInsets.all(16), 
    decoration: BoxDecoration(
      // Menggunakan warna solid kecoklatan/abu-abu hangat sesuai gambar
      color: AppColors.coklat900, 
      borderRadius: BorderRadius.circular(24), // Sudut melengkung halus sesuai gambar
    ),
    child: Stack(
      children: [
        // Icon di pojok kanan atas dengan opasitas tipis/warna emas pudar
        Positioned(
          top: 0,
          right: 0,
          child: Icon(
            stat.icon,
            color: AppColors.orange400.withValues(alpha: 0.4), // Dibuat agak transparan melengkapi desain gambar
            size: 32, // Ukuran diperbesar sedikit agar proporsional
          ),
        ),
        // Label + Value disusun vertikal
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.coklat300.withValues(alpha: 0.7), // Warna teks abu-abu muda hangat
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            const Spacer(), // Dorong value ke paling bawah card secara dinamis
            Text(
              stat.value,
              style: TextStyle(
                color: AppColors.orange300, // Warna orange/emas khas di gambar
                fontSize: 28,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  // =========================================
  // NEW: WEEKLY ACHIEVEMENTS
  // =========================================

Widget _buildWeeklyAchievements() {
  final achievements = [
    _AchievementData(emoji: '🎯', title: 'Focus Master'),
    _AchievementData(emoji: '🌤️', title: 'Early Riser'),
    _AchievementData(emoji: '💎', title: 'Consistency\nMiner'),
    _AchievementData(emoji: '⛏️', title: 'Deep Worker'),
  ];

  const double gap = 12.0; // Jarak antar kotak

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Weekly Achievements',
        style: TextStyle(
          color: AppColors.orange100,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 14),
      
      LayoutBuilder(
        builder: (context, constraints) {
          // Hitungan presisi untuk memunculkan 2 kotak utuh & 1 kotak terpotong seperempat
          final double cardWidth = (constraints.maxWidth - (2 * gap)) / 2.25;
          final double cardHeight = cardWidth; // Square sempurna

          return SizedBox(
            height: cardHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: achievements.length,
              separatorBuilder: (_, __) => const SizedBox(width: gap),
              itemBuilder: (context, index) {
                final item = achievements[index];
                return Container(
                  width: cardWidth,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.coklat900,
                    borderRadius: BorderRadius.circular(26), // Sudut bulat yang lebih besar
                    // Menambahkan border rounded berwarna biru
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.5), // Ganti dengan AppColors.biru Anda jika ada
                      width: 1.5,
                    ),
                  ),
                  // Menggunakan Center + Column untuk memastikan semua konten berada di tengah
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Mengunci column agar tingginya pas dengan konten
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Ukuran gambar emoji diperbesar lagi
                        Text(
                          item.emoji,
                          style: const TextStyle(fontSize: 42), 
                        ),
                        const SizedBox(height: 12), // Jarak antara emoji dan tulisan
                        // Ukuran tulisan diperbesar dan diposisikan di tengah
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.coklat300.withValues(alpha: 0.9),
                            fontSize: 14, // Ukuran teks diperbesar lagi agar lebih jelas
                            fontWeight: FontWeight.bold, // Dibuat tebal agar makin menonjol
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    ],
  );
}
  // =========================================
  // NEW: WEEKLY REFLECTION
  // =========================================

  Widget _buildWeeklyReflection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.orange700.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Reflection',
                style: TextStyle(
                  color: AppColors.orange100,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'This week, you stayed consistent and made meaningful progress toward your goals.',
                style: TextStyle(
                  color: AppColors.coklat300,
                  fontSize: 13.5,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // TODO: navigate to full reflection page
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.coklat800.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: AppColors.orange600.withValues(alpha: 0.5),
                      width: 1.2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'View full reflection',
                    style: TextStyle(
                      color: AppColors.orange100,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================
// MONTH DATA MODEL
// =========================================

class _MonthData {
  final String month;
  final double goalPercent;
  final List<double> weeklyBars;

  _MonthData({
    required this.month,
    required this.goalPercent,
    required this.weeklyBars,
  });
}

// =========================================
// STAT DATA MODEL (NEW)
// =========================================

class _StatData {
  final String label;
  final String value;
  final IconData? icon;

  _StatData({required this.label, required this.value, this.icon});
}

// =========================================
// ACHIEVEMENT DATA MODEL (NEW)
// =========================================

class _AchievementData {
  final String emoji;
  final String title;

  _AchievementData({required this.emoji, required this.title});
}

// =========================================
// MONTH PICKER SHEET
// =========================================

class _MonthPickerSheet extends StatelessWidget {
  final String selectedMonth;
  final List<String> months;
  final Function(String) onSelected;

  const _MonthPickerSheet({
    required this.selectedMonth,
    required this.months,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.coklat900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.orange700.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.coklat600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Pilih Bulan',
            style: TextStyle(
              color: AppColors.orange100,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: months.length,
            itemBuilder: (_, i) {
              final month = months[i];
              final isSel = month == selectedMonth;
              return GestureDetector(
                onTap: () => onSelected(month),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isSel
                        ? AppColors.orange700
                        : AppColors.coklat800.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSel
                          ? AppColors.orange400
                          : AppColors.orange700.withValues(alpha: 0.3),
                      width: isSel ? 1.5 : 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    month.split(' ').first,
                    style: TextStyle(
                      color: isSel ? AppColors.orange100 : AppColors.coklat300,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mino/pages/habit/widgets/active_habit_list_page.dart';
// import 'package:provider/provider.dart';
// import 'package:mino/core/data/model/response/dashboard_response.dart';
// import 'package:mino/providers/habit_provider.dart';
// import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
// import 'package:mino/pages/timer/timer_page.dart';

// class HabitSection extends StatelessWidget {
//   final List<TodayHabit> habits;
//   final int completed;
//   final int total;
//   final int currentDiamonds;
//   final Function(BuildContext, int, String) onDeleteHabit;
//   // 🔥 TAMBAHKAN CALLBACK UNTUK HANDLE INSTANT CHECK/UNCHECK DIAMOND DI PARENT
//   final Function(int newDiamonds) onDiamondsChanged;

//   const HabitSection({
//     super.key,
//     required this.habits,
//     required this.completed,
//     required this.total,
//     required this.currentDiamonds,
//     required this.onDeleteHabit,
//     required this.onDiamondsChanged, // Wajib diisi oleh HomePage
//   });

//   @override
//   Widget build(BuildContext context) {
//     final uncompletedHabits = habits
//         .where((h) => !(h.isCompletedToday ?? false))
//         .toList();
//     final completedHabits = habits
//         .where((h) => h.isCompletedToday ?? false)
//         .toList();
//     final habitsToShow = uncompletedHabits.isNotEmpty
//         ? uncompletedHabits
//         : completedHabits;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildHeader(context),
//         const SizedBox(height: 16),
//         if (habits.isEmpty)
//           const Text(
//             'No habits for today.',
//             style: TextStyle(color: Colors.white60),
//           )
//         else
//           ...habitsToShow.take(2).map((habit) => _buildHabitItem(context, habit)),
//         const SizedBox(height: 8),
//         _buildProgressIndicator(context),
//       ],
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Your habit',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ActiveHabitListPage(),
//             ),
//           ),
//           child: const Row(
//             children: [
//               Text(
//                 'See all',
//                 style: TextStyle(color: Color(0xFFE6A84A), fontSize: 14),
//               ),
//               Icon(Icons.chevron_right, color: Color(0xFFE6A84A)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHabitItem(BuildContext context, TodayHabit habit) {
//     final habitName = habit.habitName ?? 'No Title';
//     final idHabit = habit.userHabitId;
//     final isCompleted = habit.isCompletedToday ?? false;
//     final iconPath = context.read<HabitProvider>().getIconPath(habitName);

//     return HabitItemWidget(
//       pageContext: context,
//       iconPath: iconPath,
//       title: habitName,
//       isCompleted: isCompleted,
//       onCheckTap: () {
//         if (idHabit != null) {
//           // 🔥 KALKULASI INSTAN YANG AMAN (Mencegah drop ke 0 atau minus)
//           int updatedDiamonds = currentDiamonds;
//           if (!isCompleted) {
//             updatedDiamonds = currentDiamonds + 1; // Ditambah jika di-check
//           } else {
//             updatedDiamonds = currentDiamonds > 0 ? currentDiamonds - 1 : 0; // Dikurang jika di-uncheck
//           }

//           // Kirim state diamond terbaru ke HomePage secara real-time
//           onDiamondsChanged(updatedDiamonds);

//           // Pemicu event BLoC ke server
//           context.read<DashboardBloc>().add(
//             DashboardEvent.toggleHabit(
//               idHabit,
//               isCompleted,
//             ),
//           );
//         }
//       },
//       onTimerTap: () {
//         if (idHabit != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TimerPage(
//                 habitId: idHabit,
//                 habitName: habitName,
//               ),
//             ),
//           );
//         }
//       },
//       onEditSuccess: (newTitle) {},
//       onDelete: () {
//         if (idHabit != null) {
//           onDeleteHabit(context, idHabit, habitName);
//         }
//       },
//     );
//   }

//   Widget _buildProgressIndicator(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (!Navigator.canPop(context))
//           SizedBox(
//             width: 100,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: LinearProgressIndicator(
//                 value: total > 0 ? (completed / total) : 0,
//                 backgroundColor: Colors.white24,
//                 color: const Color(0xFFE6A84A),
//                 minHeight: 6,
//               ),
//             ),
//           ),
//         const SizedBox(width: 12),
//         Text(
//           '$completed/$total habits completed',
//           style: const TextStyle(color: Color(0xFFE6A84A), fontSize: 12),
//         ),
//       ],
//     );
//   }
// }
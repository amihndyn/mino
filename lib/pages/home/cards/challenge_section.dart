// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mino/pages/challenge/widgets/active_challenge_list_page.dart';
// import 'package:mino/pages/home/cards/challenge_item_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
// import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
// import 'package:mino/providers/challenge_provider.dart';


// class ChallengeSection extends StatelessWidget {
//   final Function(BuildContext, int, String) onDeleteChallenge;

//   const ChallengeSection({
//     super.key,
//     required this.onDeleteChallenge,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserChallengeBloc, UserChallengeState>(
//       builder: (context, state) {
//         return state.maybeWhen(
//           loading: () => const Center(
//             child: CircularProgressIndicator(color: Colors.white),
//           ),
//           error: (message) => Center(
//             child: Text(
//               "Failed to load: $message",
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//           success: (challenges) => _buildSuccessContent(context, challenges),
//           orElse: () => const SizedBox(),
//         );
//       },
//     );
//   }

//   Widget _buildSuccessContent(BuildContext context, List challenges) {
//     final now = DateTime.now();
//     final checkedTodayCount = challenges.where((c) {
//       if (c.lastProgressDate == null) return false;
//       try {
//         final lastDate = DateTime.parse(c.lastProgressDate!).toLocal();
//         return lastDate.year == now.year &&
//             lastDate.month == now.month &&
//             lastDate.day == now.day;
//       } catch (_) {
//         return false;
//       }
//     }).length;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildHeader(context),
//         const SizedBox(height: 16),
//         if (challenges.isEmpty)
//           const Text(
//             'No active challenges.',
//             style: TextStyle(color: Colors.white60),
//           )
//         else
//           ...challenges.take(2).map((challenge) => ChallengeItemWidget(
//             challenge: challenge,
//             onDelete: () => onDeleteChallenge(context, challenge.challengeId, challenge.name),
//           )),
//         const SizedBox(height: 12),
//         _buildProgressIndicator(context, checkedTodayCount, challenges.length),
//       ],
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Your Challenge',
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
//               builder: (context) => const ActiveChallengeListPage(),
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

//   Widget _buildProgressIndicator(BuildContext context, int checkedTodayCount, int totalChallenges) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: 100,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: LinearProgressIndicator(
//               value: totalChallenges > 0 ? (checkedTodayCount / totalChallenges) : 0,
//               backgroundColor: Colors.white24,
//               color: const Color(0xFFE6A84A),
//               minHeight: 6,
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Text(
//           '$checkedTodayCount/$totalChallenges challenge checked today',
//           style: const TextStyle(
//             color: Color(0xFFE6A84A),
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }
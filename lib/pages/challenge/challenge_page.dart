// import 'package:flutter/material.dart';
// import 'package:mino/widgets/appbars/custom_appbar.dart';
// import 'package:mino/widgets/navbar/bottom_navbar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mino/core/presentation/home/bloc/user_challenge/user_challenge_bloc.dart';
// import 'package:mino/core/data/model/response/user_challenge_response_model.dart';

// class ChallengePage extends StatefulWidget {
//   const ChallengePage({super.key});

//   @override
//   State<ChallengePage> createState() => _ChallengePageState();
// }

// class _ChallengePageState extends State<ChallengePage> {

//   @override
//   void initState() {
//     super.initState();

//     context.read<UserChallengeBloc>().add(
//       const UserChallengeEvent.fetchUserChallenges(),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       // 🛠️ FIX: Mengunci warna kanvas belakang agar tidak berkedip putih saat transisi page
//       backgroundColor: const Color(0xFF1A110A),
//       extendBody: true,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/bg_login.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 CustomAppBar(
//                   title: 'My Routine', // Mengubah judul menjadi dinamis
//                   showBackButton: false,
//                 ),
//                 Expanded(
//   child: BlocBuilder<UserChallengeBloc, UserChallengeState>(
//     builder: (context, state) {
//       return state.when(
//         initial: () => const SizedBox(),

//         loading: () => const Center(
//           child: CircularProgressIndicator(),
//         ),

//         error: (message) => Center(
//           child: Text(
//             message,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),

//         needRevive: (_, message) => Center(
//           child: Text(
//             message,
//             style: const TextStyle(color: Colors.orange),
//           ),
//         ),

//         success: (challenges) {
//           if (challenges.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No Challenges Yet',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(20),
//             itemCount: challenges.length,
//             itemBuilder: (context, index) {
//               final challenge = challenges[index];

//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: _challengeCard(challenge),
//               );
//             },
//           );
//         },
//       );
//     },
//   ),
// ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavbar(
//         currentIndex: 2,
//       ),
//     );
//   }

//   Widget _challengeCard(UserChallenge challenge) {
//   final progress =
//       challenge.requiredDays == 0
//           ? 0.0
//           : challenge.progressDays / challenge.requiredDays;

//   return Container(
//     padding: const EdgeInsets.all(18),
//     decoration: BoxDecoration(
//       color: Colors.black.withOpacity(0.25),
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(
//         color: Colors.white.withOpacity(0.08),
//       ),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           challenge.name,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//           ),
//         ),

//         const SizedBox(height: 6),

//         Text(
//           challenge.description,
//           style: const TextStyle(
//             color: Colors.white70,
//             fontSize: 13,
//           ),
//         ),

//         const SizedBox(height: 16),

//         Text(
//           "${challenge.progressDays}/${challenge.requiredDays} Days",
//           style: const TextStyle(
//             color: Colors.white54,
//           ),
//         ),

//         const SizedBox(height: 8),

//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: LinearProgressIndicator(
//             value: progress,
//             minHeight: 8,
//             backgroundColor: Colors.white12,
//             color: const Color(0xFFE6A84A),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }
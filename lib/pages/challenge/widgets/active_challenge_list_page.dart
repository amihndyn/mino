import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChallengeModel {
  final String iconPath;
  final String title;
  int current;
  final int total;
  bool isCompleted;

  ChallengeModel({
    required this.iconPath,
    required this.title,
    required this.current,
    required this.total,
    this.isCompleted = false,
  });
}

class ActiveChallengeListPage extends StatefulWidget {
  const ActiveChallengeListPage({super.key});

  @override
  State<ActiveChallengeListPage> createState() => _ActiveChallengeListPageState();
}

class _ActiveChallengeListPageState extends State<ActiveChallengeListPage> {
  final List<ChallengeModel> _challenges = [
    ChallengeModel(iconPath: 'assets/icons/tension.png', title: 'Release tension in your body', current: 12, total: 30),
    ChallengeModel(iconPath: 'assets/icons/clean.png', title: 'Clean your home', current: 5, total: 30),
    ChallengeModel(iconPath: 'assets/icons/healthy.png', title: 'Eat healthy', current: 12, total: 30),
    ChallengeModel(iconPath: 'assets/icons/hair.png', title: 'Hair care day', current: 5, total: 30),
  ];

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF332218),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Delete Challenge?',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'The progress this challenge cannot\nbe recovered once deleted. 💎',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _challenges.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE6A84A), width: 1.5),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Color(0xFFE6A84A), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3424),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _challenges.where((c) => c.isCompleted).length;
    int totalCount = _challenges.length;

    // LOGIKA FILTER: Ambil yang BELUM dicentang saja
    List<ChallengeModel> displayChallenges = _challenges.where((c) => !c.isCompleted).toList();

    // PENGECUALIAN: Jika semua sudah dicentang, tampilkan yang paling atas (index ke-0)
    if (displayChallenges.isEmpty && _challenges.isNotEmpty) {
      displayChallenges = [_challenges.first];
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A110A),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Today's challenges",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopProgressCard(completedCount, totalCount),
                        const SizedBox(height: 32),
                        const Text(
                          'The overall challenge',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        
                        // LOOPING MENGGUNAKAN DATA YANG SUDAH DIFILTER
                        ...List.generate(displayChallenges.length, (index) {
                          final challenge = displayChallenges[index];
                          // Cari index asli di list utama
                          final masterIndex = _challenges.indexOf(challenge);
                          return _buildChallengeItem(context, challenge, masterIndex);
                        }),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopProgressCard(int completed, int total) {
    double progressValue = total > 0 ? (completed / total) : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF261912),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6A84A).withOpacity(0.6), width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Progress Today', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('$completed/$total', style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text('Completed', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: Colors.white24,
                    color: const Color(0xFFE6A84A),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 50, width: 1, color: Colors.white24, margin: const EdgeInsets.symmetric(horizontal: 16)),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.diamond, color: Color(0xFF1CB0F6), size: 22),
                    SizedBox(width: 6),
                    Text('+7', style: TextStyle(color: Color(0xFFE6A84A), fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('diamonds earned', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeItem(BuildContext context, ChallengeModel challenge, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(challenge.title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.45,
          children: [
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFC4F0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.timer_rounded, color: Colors.black, size: 28),
                ),
              ),
            ),
            CustomSlidableAction(
              onPressed: (context) {
                _showDeleteDialog(context, index);
              },
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFC92A2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.delete_rounded, color: Colors.white, size: 28),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF5C4731),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.star, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: challenge.current / challenge.total,
                              backgroundColor: Colors.white24,
                              color: const Color(0xFFE6A84A),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${challenge.current}/${challenge.total}',
                          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    challenge.isCompleted = !challenge.isCompleted;
                    if (challenge.isCompleted) {
                      if (challenge.current < challenge.total) {
                        challenge.current++;
                      }
                    } else {
                      if (challenge.current > 0) {
                        challenge.current--;
                      }
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: challenge.isCompleted ? const Color(0xFFE6A84A) : Colors.transparent,
                    border: Border.all(
                      color: challenge.isCompleted ? const Color(0xFFE6A84A) : Colors.white,
                      width: 1.5,
                    ),
                  ),
                  child: challenge.isCompleted
                      ? const Icon(Icons.check, color: Colors.black, size: 18)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
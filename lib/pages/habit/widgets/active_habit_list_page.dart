import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// 1. MEMBUAT MODEL DATA UNTUK HABIT
class HabitModel {
  final String emoji;
  final String title;
  bool isCompleted;

  HabitModel({
    required this.emoji,
    required this.title,
    this.isCompleted = false,
  });
}

class ActiveHabitListPage extends StatefulWidget {
  const ActiveHabitListPage({super.key});

  @override
  State<ActiveHabitListPage> createState() => _ActiveHabitListPageState();
}

class _ActiveHabitListPageState extends State<ActiveHabitListPage> {
  // 2. KUMPULAN DATA HABIT (STATE)
  final List<HabitModel> _habits = [
    HabitModel(emoji: '📚', title: 'Take a deep breath'),
    HabitModel(emoji: '🌞', title: 'Smile for a few seconds'),
    HabitModel(emoji: '🧘', title: 'Fix your posture'),
    HabitModel(emoji: '💻', title: 'Creative Time'),
    HabitModel(emoji: '📔', title: 'Journaling'),
    HabitModel(emoji: '🎙️', title: 'Listen to Podcast'),
  ];

  // --- FUNGSI POP UP DELETE ---
  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF332218),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Delete Habit?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The progress this habit cannot\nbe recovered once deleted. 💎',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    // TOMBOL DELETE
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _habits.removeAt(index); // Hapus data habit dari list
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
                            style: TextStyle(
                              color: Color(0xFFE6A84A),
                              fontWeight: FontWeight.w600,
                              ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // TOMBOL CANCEL
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
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
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
    // Menghitung progress secara otomatis berdasarkan jumlah data di list
    int completedCount = _habits.where((h) => h.isCompleted).length;
    int totalCount = _habits.length;

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
                // APP BAR CUSTOM
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Today's habit",
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
                        // KOTAK PROGRESS OTOMATIS
                        _buildTopProgressCard(completedCount, totalCount),
                        const SizedBox(height: 32),

                        const Text('The overall habit', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),

                        // LOOPING DATA HABIT SECARA DINAMIS
                        ...List.generate(_habits.length, (index) {
                          return _buildHabitItem(context, _habits[index], index);
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

  // Widget Card Progress Atas
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

  // --- WIDGET LIST ITEM HABIT ---
  Widget _buildHabitItem(BuildContext context, HabitModel habit, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(habit.title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.65, 
          children: [
            // TOMBOL STOPWATCH
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
            
            // TOMBOL EDIT
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0), 
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.edit_rounded, color: Colors.black, size: 28),
                ),
              ),
            ),
            
            // TOMBOL DELETE
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
            color: const Color(0xFFEEDDCC), 
            borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              Text(habit.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  habit.title, 
                  style: TextStyle(
                    color: const Color(0xFF4A3A2A), 
                    fontWeight: FontWeight.w500,
                    // Opsional: memberi efek coret pada teks jika habit selesai dicentang
                    decoration: habit.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ),
              
              // 3. BULATAN CENTANG DENGAN ANIMATED CONTAINER & GESTURE DETECTOR
              GestureDetector(
                onTap: () {
                  setState(() {
                    habit.isCompleted = !habit.isCompleted;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24, 
                  height: 24, 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    // Jika selesai, lingkaran akan terisi warna penuh
                    color: habit.isCompleted ? const Color(0xFF4A3A2A) : Colors.transparent,
                    border: Border.all(color: const Color(0xFF4A3A2A), width: 1.5)
                  ),
                  child: habit.isCompleted
                      ? const Icon(Icons.check, color: Color(0xFFEEDDCC), size: 16)
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
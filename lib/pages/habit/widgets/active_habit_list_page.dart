import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // WAJIB IMPORT INI

class ActiveHabitListPage extends StatelessWidget {
  const ActiveHabitListPage({super.key});

  // --- FUNGSI POP UP DELETE ---
  void _showDeleteDialog(BuildContext context, String type) {
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
                Text(
                  'Delete $type?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The progress this $type cannot\nbe recovered once deleted. 💎',
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
                          // TODO: Tambahkan logika hapus data di sini
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
                    // TOMBOL CANCEL (Custom Button onTap)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Tutup pop up
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3424),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE6A84A).withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
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
                        // KOTAK PROGRESS
                        _buildTopProgressCard(),
                        const SizedBox(height: 32),

                        const Text('The overall habit', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),

                        // LIST HABIT (Sekarang me-lempar context ke dalam fungsi)
                        _buildHabitItem(context, '📚', 'Take a deep breath'),
                        _buildHabitItem(context, '🌞', 'Smile for a few seconds'),
                        _buildHabitItem(context, '🧘', 'Fix your posture'),
                        _buildHabitItem(context, '💻', 'Creative Time'),
                        _buildHabitItem(context, '📔', 'Journaling'),
                        _buildHabitItem(context, '🎙️', 'Listen to Podcast'),
                        
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

  Widget _buildTopProgressCard() {
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
                    const Text('2/9', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text('Completed', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(value: 2/9, backgroundColor: Colors.white24, color: Color(0xFFE6A84A), minHeight: 6),
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

  // --- HABIT ITEM DENGAN SLIDABLE ---
  Widget _buildHabitItem(BuildContext context, String emoji, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.65, // Lebar area swipe
          children: [
            // TOMBOL STOPWATCH
            CustomSlidableAction(
              onPressed: (context) {
                // TODO: Navigasi ke page timer
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TimerPage()));
              },
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
              onPressed: (context) {
                // TODO: Edit
              },
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
                _showDeleteDialog(context, 'Habit'); // Panggil Dialog Pop-up
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
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF4A3A2A), fontWeight: FontWeight.w500))),
              Container(
                width: 24, height: 24, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  border: Border.all(color: const Color(0xFF4A3A2A), width: 1.5)
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
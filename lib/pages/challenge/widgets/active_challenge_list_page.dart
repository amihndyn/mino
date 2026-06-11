import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // WAJIB IMPORT INI

class ActiveChallengeListPage extends StatelessWidget {
  const ActiveChallengeListPage({super.key});

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
                        // KOTAK PROGRESS
                        _buildTopProgressCard(),
                        const SizedBox(height: 32),

                        const Text('The overall challenge', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),

                        // LIST CHALLENGE (Tambahkan context di parameter pertama)
                        _buildChallengeItem(context, 'assets/icons/tension.png', 'Release tension in your body', 12, 30),
                        _buildChallengeItem(context, 'assets/icons/clean.png', 'Clean your home', 5, 30),
                        _buildChallengeItem(context, 'assets/icons/healthy.png', 'Eat healthy', 12, 30),
                        _buildChallengeItem(context, 'assets/icons/hair.png', 'Hair care day', 5, 30),
                        
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

  // --- CHALLENGE ITEM DENGAN SLIDABLE (TANPA TOMBOL EDIT) ---
  Widget _buildChallengeItem(BuildContext context, String iconPath, String title, int current, int total) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          // Ratio dikecilkan jadi 0.45 karena cuma butuh 2 tombol
          extentRatio: 0.45, 
          children: [
            // 1. TOMBOL STOPWATCH
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
            
            // 2. TOMBOL DELETE (Tidak ada tombol Edit)
            CustomSlidableAction(
              onPressed: (context) {
                _showDeleteDialog(context, 'Challenge'); // Panggil Dialog Pop-up
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
            borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              // Emoji dummy (bisa diganti dengan Image.asset(iconPath) jika gambar sudah siap)
              const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.star, color: Colors.white)), 
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: current / total,
                              backgroundColor: Colors.white24,
                              color: const Color(0xFFE6A84A),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('$current/$total', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 26, height: 26, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  border: Border.all(color: Colors.white, width: 1.5)
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
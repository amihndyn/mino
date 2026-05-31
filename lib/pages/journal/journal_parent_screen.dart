import 'package:flutter/material.dart';
import 'package:mino/pages/journal/journal_page.dart';
import 'package:mino/pages/journal/progress_page.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

class JournalParentScreen extends StatefulWidget {
  final int initialTabIndex;

  const JournalParentScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<JournalParentScreen> createState() => _JournalParentScreenState();
}

class _JournalParentScreenState extends State<JournalParentScreen> {
  late int _tabIndex;
  int _navIndex = 1; // Default index 1 untuk halaman Journal

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.initialTabIndex;
  }

  void _handleTabChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Membuat dasar transparan agar background terekspos sempurna
      backgroundColor: Colors.transparent,
      
      // 2. Membiarkan body memanjang ke bawah menembus lengkungan transparan navbar
      extendBody: true,
      
      body: Stack(
        children: [
          // Background gambar goa/batu full screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Konten Utama Jurnal / Progress
          SafeArea(
            bottom: false, // DIUBAH KE FALSE agar background meluncur mulus ke bawah navbar
            child: IndexedStack(
              index: _tabIndex,
              children: [
                JournalPage(
                  currentTabIndex: _tabIndex,
                  onTabChanged: _handleTabChanged,
                ),
                ProgressPage(
                  currentTabIndex: _tabIndex,
                  onTabChanged: _handleTabChanged,
                ),
              ],
            ),
          ),
        ],
      ),
      
      // 3. Pasang BottomNavbar Custom kamu yang sudah mendukung animasi melompat hancur/smooth
      bottomNavigationBar: BottomNavbar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() {
            _navIndex = i;
          });
          // TODO: Tambahkan logika perpindahan antar halaman utama di sini jika diperlukan 
          // (misal jika _navIndex == 0 balik ke TodayPage, dll.)
        },
      ),
    );
  }
}
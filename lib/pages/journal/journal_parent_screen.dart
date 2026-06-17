import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:mino/core/data/repositories/dashboard_repository.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
// 🔥 1. TAMBAHKAN IMPORT DATASOURCE INI AGAR BISA DIMASUKKAN KE REPOSITORY
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/journal/journal_page.dart';
import 'package:mino/pages/journal/progress_page.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

class JournalParentScreen extends StatefulWidget {
  final int initialTabIndex;

  const JournalParentScreen({super.key, this.initialTabIndex = 0});

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
      // 🛠️ FIX: Mengunci warna dasar kanvas belakang menjadi gelap untuk mencegah kedipan putih
      backgroundColor: AppColors.coklat900,
      extendBody: true,
      body: Stack(
        children: [
          // Background gambar goa/batu full screen
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          // Konten Utama Jurnal / Progress
          BlocProvider(
            // 🔥 2. SEKARANG PARAMETERNYA SUDAH LENGKAP & TIDAK MERAH LAGI
            create: (context) => DashboardBloc(
              DashboardRepository(
                remoteDatasource: DashboardRemoteDatasource(), 
              ),
            )..add(const DashboardEvent.fetchDashboardData()),
            child: SafeArea(
              bottom: false,
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() {
            _navIndex = i;
          });
        },
      ),
    );
  }
}
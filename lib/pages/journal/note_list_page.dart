import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/providers/journal_provider.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/pages/journal/note_detail_page.dart';

class NoteListPage extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? pageTitle; // Tambahan untuk membedakan judul Weekly/Monthly

  const NoteListPage({
    super.key,
    this.startDate,
    this.endDate,
    this.pageTitle,
  });

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavbar(
        currentIndex: 1,
        onTap: (index) {},
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          SafeArea(
            child: Column(
              children: [
                // Gunakan pageTitle jika ada, kalau tidak kembali ke default
                CustomAppBar(
                  title: widget.pageTitle ?? ((widget.startDate != null) ? 'Filtered Notes' : 'Notes'),
                ),
                
                // Sembunyikan Tab Switcher jika sedang dalam mode filter
                if (widget.startDate == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: JournalTabSwitch(
                      selectedIndex: _currentTabIndex,
                      onChanged: (index) {
                        setState(() {
                          _currentTabIndex = index;
                        });
                      },
                    ),
                  ),
                const SizedBox(height: AppSizes.md),

                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: Consumer<JournalProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.orange400,
                              ),
                            );
                          }

                          var filteredJournals = provider.journals;

                          if (widget.startDate != null && widget.endDate != null) {
                            filteredJournals = filteredJournals.where((journal) {
                              final dateString = journal.fullDate ?? "";
                              
                              if (dateString.isEmpty) return true;

                              try {
                                String datePart = dateString.split(' at ')[0].trim();
                                DateTime noteDate = DateFormat("EEEE, d MMMM yyyy").parse(datePart);
                                
                                return noteDate.isAfter(widget.startDate!.subtract(const Duration(days: 1))) && 
                                       noteDate.isBefore(widget.endDate!.add(const Duration(days: 1)));
                              } catch (e) {
                                debugPrint("Error parsing date: $e");
                                return true;
                              }
                            }).toList();
                          }

                          if (filteredJournals.isEmpty) {
                            return Center(
                              child: Text(
                                widget.startDate != null 
                                    ? 'No notes found for this period.'
                                    : 'No notes available.',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1, // 🔥 Tambah letterSpacing di sini
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(
                              AppSizes.md,
                              AppSizes.xs,
                              AppSizes.md,
                              120, 
                            ),
                            itemCount: filteredJournals.length,
                            itemBuilder: (context, index) {
                              final journal = filteredJournals[index];
                              return _buildNoteCard(context, journal);
                            },
                          );
                        },
                      ),
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

  Widget _buildNoteCard(BuildContext context, dynamic journal) {
    final title = journal.noteTitle ?? "Untitled";
    final content = journal.noteContent ?? "";
    final date = journal.fullDate ?? "April 18, 2026";
    final emoji = journal.moodEmoji ?? 'assets/images/good.png';
    final label = journal.moodLabel ?? "Good";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteDetailPage(
              noteTitle: title,
              noteContent: content,
              fullDate: date,
              mood: emoji,
              moodLabel: label,
              moodColor: AppColors.orange300,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0x4DE6A84A), width: 1),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x26E6A84A), Color(0x0D3FA7C4)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Tambah letterSpacing: 1 di Teks Tanggal
            Text(
              date, 
              style: const TextStyle(
                color: Color(0xFFD2D2D2), 
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 6),
            // 🔥 Tambah letterSpacing: 1 di Teks Judul
            Text(
              title, 
              style: const TextStyle(
                color: Color(0xFFE6A84A), 
                fontSize: 22, 
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            // 🔥 Tambah letterSpacing: 1 di Teks Konten
            Text(
              content,
              style: TextStyle(
                color: const Color(0xFFD2D2D2).withOpacity(0.8), 
                fontSize: 13, 
                height: 1.4,
                letterSpacing: 1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
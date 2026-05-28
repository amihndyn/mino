// ============================================
// NOTE DETAIL PAGE
// ============================================

import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';

class NoteDetailPage extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final String fullDate;
  final String mood;
  final String moodLabel;
  final Color moodColor;

  const NoteDetailPage({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.fullDate,
    required this.mood,
    required this.moodLabel,
    required this.moodColor,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

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
      body: Stack(
        children: [
          // BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay
          Container(
            color: Colors.black.withValues(alpha: 0.5),
          ),

          // CONTENT
          SafeArea(
            child: Column(
              children: [
                // APPBAR
                CustomAppBar(
                  title: 'Notes',
                  actions: [
                    GestureDetector(
                      onTap: () {
                        // Edit functionality
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.edit_outlined,
                          color: AppColors.orange300,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),

                // SCROLLABLE CONTENT
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          AppSizes.md,
                          AppSizes.sm,
                          AppSizes.md,
                          AppSizes.xl,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // MOOD CHIP
                            _buildMoodChip(),

                            const SizedBox(height: 20),

                            // TITLE
                            Text(
                              widget.noteTitle,
                              style: TextStyle(
                                color: widget.moodColor,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                letterSpacing: 0.2,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // DATE
                            Text(
                              widget.fullDate,
                              style: TextStyle(
                                color: AppColors.coklat300,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // DIVIDER
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.orange700.withValues(alpha: 0.5),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // CONTENT PARAGRAPHS
                            ...widget.noteContent.split('\n\n').map(
                              (para) => Padding(
                                padding: const EdgeInsets.only(bottom: 18),
                                child: Text(
                                  para.trim(),
                                  style: TextStyle(
                                    color: AppColors.orange100,
                                    fontSize: 15.5,
                                    height: 1.75,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildMoodChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.coklat900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: widget.moodColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.mood,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mood',
                style: TextStyle(
                  color: AppColors.coklat300,
                  fontSize: 10,
                ),
              ),
              Text(
                widget.moodLabel,
                style: TextStyle(
                  color: widget.moodColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
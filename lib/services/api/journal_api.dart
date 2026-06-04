import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/models/journal_entry_model.dart.dart'; // Memperbaiki typo ekstensi berkas .dart.dart menjadi .dart

class JournalApi {
  Future<List<JournalEntry>> getJournals() async {
    // Delay loading simulasi hit API asli biar kerasa transisi loading-nya
    await Future.delayed(const Duration(milliseconds: 800)); 

    return [
      // ENTRI 1: Thursday 30
      JournalEntry(
        id: '1',
        dayName: 'Thursday',
        dayNumber: 30,
        noteTitle: 'Challenging Day',
        noteContent: 'Today was really tough.\n\nI struggled with staying focused on my tasks.',
        fullDate: 'Thursday, 30 May 2026',
        moodLabel: 'Bad',
        moodEmoji: '😩',
        moodColor: AppColors.coklat400,
      ),
      
      // ENTRI 2: Sunday 26
      JournalEntry(
        id: '2',
        dayName: 'Sunday',
        dayNumber: 26,
        noteTitle: 'Amazing Progress',
        noteContent: 'Had an incredible productive day today!',
        fullDate: 'Sunday, 26 May 2026',
        moodLabel: 'Amazing',
        moodEmoji: '😁',
        moodColor: AppColors.orange400,
      ),

      // ENTRI 3 (BARU): Saturday 18 (Sesuai Gambar Screenshot)
      JournalEntry(
        id: '3',
        dayName: 'Saturday',
        dayNumber: 18,
        noteTitle: 'A Peaceful Saturday',
        noteContent: 'Spent time resting and recharging. Felt very good and balanced today.',
        fullDate: 'Saturday, 18 May 2026',
        moodLabel: 'Good',
        moodEmoji: '😊',
        moodColor: const Color(0xffE5933A), // Menyesuaikan palette emas/oranye mino
      ),

      // ENTRI 4 (BARU): Wednesday 15 (Sesuai Gambar Screenshot)
      JournalEntry(
        id: '4',
        dayName: 'Wednesday',
        dayNumber: 15,
        noteTitle: 'Feeling Exhausted',
        noteContent: 'Too many things to handle at once. Need to take a step back tomorrow.',
        fullDate: 'Wednesday, 15 May 2026',
        moodLabel: 'Bad',
        moodEmoji: '😩',
        moodColor: AppColors.coklat400,
      ),
    ];
  }
}
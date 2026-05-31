import 'package:flutter/material.dart';

class JournalEntry {
  final String id; // Tambahkan ID unik di sini
  final String dayName;
  final int dayNumber;
  final String noteTitle;
  final String noteContent;
  final String fullDate;
  final String moodLabel;
  final String moodEmoji;
  final Color moodColor;

  const JournalEntry({
    required this.id,
    required this.dayName,
    required this.dayNumber,
    required this.noteTitle,
    required this.noteContent,
    required this.fullDate,
    required this.moodLabel,
    required this.moodEmoji,
    required this.moodColor,
  });
}
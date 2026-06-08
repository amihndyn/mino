import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 🔥 Wajib dipastikan package intl sudah terinstall
import 'calendar_day_item.dart';

class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil waktu hari ini
    final now = DateTime.now();
    
    // 2. Cari hari Minggu (awal minggu ini) dengan mengurangi hari berjalan saat ini
    // now.weekday bernilai 1 (Senin) sampai 7 (Minggu)
    final int currentWeekday = now.weekday;
    final DateTime sundayOfThisWeek = currentWeekday == 7 
        ? now 
        : now.subtract(Duration(days: currentWeekday));

    // 3. Buat list berisi 7 hari (Minggu sampai Sabtu) secara dinamis
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        // Tambahkan index (0-6) dari hari Minggu untuk mendapatkan urutan tanggal minggu ini
        final DateTime dayDateTime = sundayOfThisWeek.add(Duration(days: index));
        
        // Format Nama Hari singkat (Sun, Mon, Tue, dst.)
        final String dayName = DateFormat('E').format(dayDateTime);
        
        // Format Angka Tanggal (1, 2, 15, 30, dst.)
        final String dateNum = DateFormat('d').format(dayDateTime);
        
        // Cek apakah tanggal item ini sama dengan tanggal hari ini di HP user
        final bool isToday = dayDateTime.year == now.year &&
            dayDateTime.month == now.month &&
            dayDateTime.day == now.day;

        // 4. Masukkan ke dalam widget anak
        return CalendarDayItem(
          day: dayName,
          date: dateNum,
          isSelected: isToday, // 🔥 Otomatis melingkari/menyorot hari ini!
        );
      }),
    );
  }
}
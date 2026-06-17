import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 🔥 Import intl
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/note_detail_page.dart'; 
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/data/model/response/reflection_response_model.dart';

class JournalGrid extends StatelessWidget {
  final List<Reflection> entries; 
  final VoidCallback? onTapWeeklyReflection; 

  const JournalGrid({
    super.key,
    required this.entries,
    this.onTapWeeklyReflection, 
  });

  // Fungsi pembantu parsing tanggal agar halaman detail mendapatkan format yang sama rapi
  String _formatApiDate(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return "No Date";
    try {
      DateTime parsedDate = DateTime.parse(apiDate);
      return DateFormat("EEEE, d MMMM yyyy").format(parsedDate);
    } catch (e) {
      return apiDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: entries.length,
          separatorBuilder: (context, index) => const SizedBox(height: 30),
          itemBuilder: (context, index) {
            final reflection = entries[index];
            
            // 💡 LOGIKA MAPPING MOOD (Disamakan agar data ke NoteDetailPage sinkron)
            final String moodString = reflection.mood?.toLowerCase() ?? "good";
            String emoji = 'assets/images/good.png';
            String label = "Good";

            if (moodString == 'amazing') {
              emoji = 'assets/images/amazing.png';
              label = "Amazing";
            } else if (moodString == 'good') {
              emoji = 'assets/images/good.png';
              label = "Good";
            } else if (moodString == 'okey' || moodString == 'neutral') {
              emoji = 'assets/images/okey.png';
              label = "Okey";
            } else if (moodString == 'unusual') {
              emoji = 'assets/images/unusual.png';
              label = "Unusual";
            } else if (moodString == 'bad') {
              emoji = 'assets/images/bad.png';
              label = "Bad";
            }

            final formattedDate = _formatApiDate(reflection.date);

            return JournalCard(
              entry: reflection, 
              onSeeNote: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailPage(
                      noteTitle: reflection.title ?? "Untitled",
                      noteContent: reflection.content ?? "",
                      fullDate: formattedDate, // 🟢 Tanggal yang sudah rapi
                      mood: emoji,             // 🟢 Emoji yang sesuai asset
                      moodLabel: label,         // 🟢 Label teks mood yang sesuai
                      moodColor: AppColors.orange300,
                    ),
                  ),
                );
              },
            );
          },
        ),

        const SizedBox(height: 30),

        // ==========================================
        // 2. KARTU WEEKLY REFLECTION (372 x 97)
        // ==========================================
        Container(
          width: 372, 
          height: 97, 
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // Padding disesuaikan agar teks muat dalam tinggi 97
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(width: 1, color: Color(0x33E6A84A)),
            ),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            image: DecorationImage(
              image: AssetImage('assets/images/bMood.jpeg'), 
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // Menjaga konten tetap di tengah secara vertikal
            children: [
              const Text(
                'Weekly Reflection',
                style: TextStyle(
                  fontSize: 16, // Sedikit dikecilkan agar proporsional dengan tinggi kartu 97
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: Color(0xFFF5E6D3),
                ),
              ),
              const SizedBox(height: 4),
              Opacity(
                opacity: 0.8,
                child: const Text(
                  'This week, you stayed consistent and made meaningful progress.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Menghindari text overflow jika teks terlalu panjang
                  style: TextStyle(
                    fontSize: 12, // Sedikit dikecilkan agar pas dalam tinggi 97
                    fontFamily: 'Poppins',
                    height: 1.3,
                    color: Color(0xFFF5E6D3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
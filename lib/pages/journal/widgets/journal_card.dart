import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:mino/core/data/model/response/reflection_response_model.dart';

// ✅ Import Flutter SVG dihapus karena tidak digunakan lagi

class JournalCard extends StatefulWidget {
  final Reflection entry; 
  final VoidCallback? onSeeNote;

  const JournalCard({
    super.key,
    required this.entry,
    this.onSeeNote,
  });

  @override
  State<JournalCard> createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard> {
  bool _isPressed = false;

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
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double scale = (screenWidth / 375).clamp(0.8, 1.2);

    final String moodString = widget.entry.mood?.toLowerCase() ?? "good";
    String emojiAsset = 'assets/images/good.png';
    String moodLabelText = "Good";

    if (moodString == 'amazing') {
      emojiAsset = 'assets/images/amazing.png';
      moodLabelText = "Amazing";
    } else if (moodString == 'good') {
      emojiAsset = 'assets/images/good.png';
      moodLabelText = "Good";
    } else if (moodString == 'okey' || moodString == 'neutral') {
      emojiAsset = 'assets/images/okey.png'; 
      moodLabelText = "Okey";
    } else if (moodString == 'unusual') {
      emojiAsset = 'assets/images/unusual.png';
      moodLabelText = "Unusual";
    } else if (moodString == 'bad') {
      emojiAsset = 'assets/images/bad.png';
      moodLabelText = "Bad";
    }

    final String formattedDate = _formatApiDate(widget.entry.date);

    // Variabel bantuan untuk radius agar konsisten
    final BorderRadius cardRadius = BorderRadius.circular(28 * scale);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onSeeNote,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          // ✅ Padding dikembalikan ke Container utama
          padding: EdgeInsets.all(20 * scale), 
          decoration: BoxDecoration(
            borderRadius: cardRadius, 
            border: Border.all(
              color: const Color(0xFFE6A84A).withValues(alpha: 0.5), 
              width: 1.5 * scale,
            ),
            // 🔥 PERUBAHAN DISINI: Menggunakan bgMood.png sebagai background
            image: const DecorationImage(
              image: AssetImage('assets/images/bMood.jpeg'), 
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 12 * scale,
                offset: Offset(0, 6 * scale),
              ),
            ],
          ),
          // ✅ Struktur ClipRRect dan Stack dihapus, kembali ke Column langsung
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 15 * scale, 
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFF5E6D3),
                ),
              ),
              SizedBox(height: 10 * scale),
              
              Row(
                children: [
                  Container(
                    width: 58 * scale,  
                    height: 58 * scale, 
                    padding: EdgeInsets.all(2 * scale),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE6A84A).withValues(alpha: 0.4),
                        width: 1.5 * scale,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        emojiAsset, 
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.sentiment_neutral_rounded,
                          color: Colors.white70,
                          size: 36 * scale,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 14 * scale),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'mood today',
                          style: TextStyle(
                            fontSize: 11 * scale, 
                            fontFamily: 'Poppins',
                            color: const Color(0xFFE6A84A),
                          ),
                        ),
                        SizedBox(height: 2 * scale),
                        Text(
                          moodLabelText, 
                          style: TextStyle(
                            fontSize: 22 * scale, 
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(width: 10 * scale),
                  
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14 * scale, 
                      vertical: 8 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8C6439).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(20 * scale),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'see my note ',
                          style: TextStyle(
                            fontSize: 11 * scale,
                            fontFamily: 'Poppins',
                            color: const Color(0xFFF5E6D3),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '›',
                          style: TextStyle(
                            fontSize: 12 * scale,
                            fontFamily: 'Poppins',
                            color: const Color(0xFFF5E6D3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
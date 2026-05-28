import 'package:flutter/material.dart';

class CalendarDayItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const CalendarDayItem({
    super.key,
    required this.day,
    required this.date,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            color: isSelected
                ? const Color(0xffE6A84A)
                : Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xffE6A84A)
                : Colors.transparent,

            borderRadius: BorderRadius.circular(16),

            border: Border.all(
              color: const Color(0xffE6A84A),
            ),
          ),
          child: Text(
            date,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xff59463D)
                  : const Color(0xffE6A84A),

              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
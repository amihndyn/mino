import 'package:flutter/material.dart';

import 'calendar_day_item.dart';

class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        CalendarDayItem(
          day: "Sun",
          date: "19",
        ),
        CalendarDayItem(
          day: "Mon",
          date: "20",
          isSelected: true,
        ),
        CalendarDayItem(
          day: "Tue",
          date: "21",
        ),
        CalendarDayItem(
          day: "Wed",
          date: "22",
        ),
        CalendarDayItem(
          day: "Thu",
          date: "23",
        ),
        CalendarDayItem(
          day: "Fri",
          date: "24",
        ),
        CalendarDayItem(
          day: "Sat",
          date: "25",
        ),
      ],
    );
  }
}
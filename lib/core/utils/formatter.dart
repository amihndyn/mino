class Formatter {
  // FORMAT DATE
  static String formatDate(
    DateTime date,
  ) {
    return
        '${date.day}/${date.month}/${date.year}';
  }

  // FORMAT PERCENT
  static String formatPercent(
    double value,
  ) {
    return '${(value * 100).toInt()}%';
  }

  // CAPITALIZE
  static String capitalize(
    String text,
  ) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() +
        text.substring(1);
  }
}
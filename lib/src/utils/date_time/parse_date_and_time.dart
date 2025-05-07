import '../extract_int.dart';

class ParsedDateAndTime {
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;

  ParsedDateAndTime({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
  });
}

var defaultDateAndTime = ParsedDateAndTime(year: 1900, month: 1, day: 1, hour: 1, minute: 1);

ParsedDateAndTime parseDateAndTime(String dateAndTime) { // '2024-07-20 23:48'
  List<String> segments = dateAndTime.split('-');
  final year = segments.first;
  final month = segments[1];
  final day = segments[2].substring(0, 2);
  final hour = dateAndTime.substring(11, 13);
  final minute = dateAndTime.substring(13);

  final yearInt = extractInt(year);
  final monthInt = extractInt(month);
  final dayInt = extractInt(day);
  final hourInt = extractInt(hour);
  final minuteInt = extractInt(minute);

  return ParsedDateAndTime(
    year: yearInt == -1 ? defaultDateAndTime.year : yearInt,
    month: monthInt == -1 ? defaultDateAndTime.month : monthInt,
    day: dayInt == -1 ? defaultDateAndTime.day : dayInt,
    hour: hourInt == -1 ? defaultDateAndTime.hour: hourInt,
    minute: minuteInt == -1 ? defaultDateAndTime.minute : minuteInt,
  );
}

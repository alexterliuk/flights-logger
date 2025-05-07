import 'parse_date_and_time.dart';

DateTime toDateTime(String dateAndTime) { // e.g. '2024-07-20 23:48'
  final parsedDT = parseDateAndTime(dateAndTime);

  return DateTime(
    parsedDT.year,
    parsedDT.month,
    parsedDT.day,
    parsedDT.hour,
    parsedDT.minute,
  );
}

import '../extract_int.dart';
import 'get_month_readable.dart';
import 'get_date_string_without_time.dart';

/// dateAndTimeStart, dateAndTimeEnd - 'YYYY-MM-DD HH:mm'
String getStartEndDates (
  String dateAndTimeStart,
  String dateAndTimeEnd,
  {
    bool withYear = false,
    bool fullMonthName = false,
  }
) {

  if (dateAndTimeStart.isEmpty || dateAndTimeEnd.isEmpty) return '';

  final start = getDateStringWithoutTimeFromDateString(dateAndTimeStart);
  final end = getDateStringWithoutTimeFromDateString(dateAndTimeEnd);

  int startYear = extractInt(start.substring(0, 4));
  int startMonth = extractInt(start.substring(5, 7));
  int startDay = extractInt(start.substring(8, 10));

  int endYear = extractInt(end.substring(0, 4));
  int endMonth = extractInt(end.substring(5, 7));
  int endDay = extractInt(end.substring(8, 10));

  String startMonthReadable = getMonthReadable(startMonth, Language.en);

  if (start == end) {
    return withYear
      ? '$startDay $startMonthReadable $startYear'
      : '$startDay $startMonthReadable';
  }

  String endMonthReadable = getMonthReadable(endMonth, Language.en);

  if (startMonthReadable == endMonthReadable && startYear == endYear) {
    return withYear
      ? '$startDay-$endDay $startMonthReadable $startYear'
      : '$startDay-$endDay $startMonthReadable';
  }

  if (startMonthReadable == endMonthReadable && startYear != endYear) {
    return '$startDay $startMonthReadable $startYear - $endDay $endMonthReadable $endYear';
  }

  return withYear
    ? '$startDay $startMonthReadable $startYear - $endDay $endMonthReadable $endYear'
    : '$startDay $startMonthReadable - $endDay $endMonthReadable';
}

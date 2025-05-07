import 'to_date_time.dart';

bool isFirstDateAndTimeLater(String firstDateAndTime, String secondDateAndTime) {
  final firstDT = toDateTime(firstDateAndTime);
  final secondDT = toDateTime(secondDateAndTime);

  return firstDT.isAfter(secondDT);
}

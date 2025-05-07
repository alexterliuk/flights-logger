import 'to_date_time.dart';

bool isFirstDateAndTimeEarlier(String firstDateAndTime, String secondDateAndTime) {
  final firstDT = toDateTime(firstDateAndTime);
  final secondDT = toDateTime(secondDateAndTime);

  return firstDT.isBefore(secondDT);
}

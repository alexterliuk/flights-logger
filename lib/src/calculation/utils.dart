import '../utils/date_time/is_first_date_and_time_earlier.dart';
import '../utils/date_time/is_first_date_and_time_later.dart';
import '../utils/date_time/to_date_time.dart';
import 'flight_minutes_model.dart';

String minutesToTimeString(int minutes) {
  // e.g. 14, 67, 361
  bool isMoreThanHour = minutes > 60;
  if (isMoreThanHour) {
    int mm = minutes % 60;
    int hh = (minutes / 60).toInt();

    return '${hh}h ${mm}m';
  }

  return '${minutes}m';
}

String resolveDayOrNightFlight(FlightMinutesModel minutes) {
  if (minutes.atDay != minutes.atNight) {
    return minutes.atDay > minutes.atNight ? 'day' : 'night';
  }

  return 'unresolved';
}

DateTime? findEarliestDate(List<String> dateAndTimes) {
  if (dateAndTimes.isEmpty) {
    return null;
  }

  String earliestDate = dateAndTimes.first;

  for (final date in dateAndTimes) {
    if (date == earliestDate) {
      continue;
    }

    if (isFirstDateAndTimeEarlier(date, earliestDate)) {
      earliestDate = date;
    }
  }

  return toDateTime(earliestDate);
}

DateTime? findLatestDate(List<String> dateAndTimes) {
  if (dateAndTimes.isEmpty) {
    return null;
  }

  String latestDate = dateAndTimes.first;

  for (final date in dateAndTimes) {
    if (date == latestDate) {
      continue;
    }

    if (isFirstDateAndTimeLater(date, latestDate)) {
      latestDate = date;
    }
  }

  return toDateTime(latestDate);
}

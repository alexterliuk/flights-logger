import '../utils/date_time/is_first_date_and_time_earlier.dart';
import '../utils/date_time/is_first_date_and_time_later.dart';
import '../utils/date_time/to_date_time.dart';
import 'flight_minutes_model.dart';

String resolveDayOrNightFlight(FlightMinutesModel minutes) {
  if (minutes.atDay != minutes.atNight) {
    return minutes.atDay > minutes.atNight ? 'day' : 'night';
  }

  return 'unresolved';
}

enum FindDateMode {
  earliest,
  latest,
}

DateTime? findDate(List<String> dateAndTimes, { required FindDateMode mode }) {
  if (dateAndTimes.isEmpty) {
    return null;
  }

  String targetDate = dateAndTimes.first;

  for (final date in dateAndTimes) {
    if (date == targetDate) {
      continue;
    }

    var find = mode == FindDateMode.earliest
      ? isFirstDateAndTimeEarlier
      : isFirstDateAndTimeLater;

    if (find(date, targetDate)) {
      targetDate = date;
    }
  }

  return toDateTime(targetDate);
}

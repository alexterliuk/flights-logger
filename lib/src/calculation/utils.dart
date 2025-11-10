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

import '../../prepend_zero_if_needed.dart';

class LandingTime {
  final String time;
  final DateTime dateTime;
  final bool isInvalid;

  LandingTime(this.time, this.dateTime, this.isInvalid); 
}

LandingTime calcLandingTime (DateTime takeoffDateTime, int flightTimeMinutes) {
  final landingDateTime = takeoffDateTime.add(Duration(minutes: flightTimeMinutes));
  final landingHour = prependZeroIfNeeded('${landingDateTime.hour}');
  final landingMinute = prependZeroIfNeeded('${landingDateTime.minute}');
  final landingTime = '$landingHour:$landingMinute';

  return LandingTime(landingTime, landingDateTime, false);
}

class LandingTime {
  final String time;
  final DateTime dateTime;
  final bool isInvalid;

  LandingTime(this.time, this.dateTime, this.isInvalid); 
}

LandingTime calcLandingTime (DateTime takeoffDateTime, int flightTimeMinutes) {
  final landingDateTime = takeoffDateTime.add(Duration(minutes: flightTimeMinutes));
  final landingH = landingDateTime.hour;
  final landingM = landingDateTime.minute;

  // TODO: use prependZeroIfNeeded
  final landingHour = landingH < 10 ? '0$landingH' : landingH;
  final landingMinute = landingM < 10 ? '0$landingM' : landingM;

  final landingTime = '$landingHour:$landingMinute';

  return LandingTime(landingTime, landingDateTime, false);
}

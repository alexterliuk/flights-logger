class HomeModel {
  int topFlightTimeMinutes;
  int topDistanceMeters;
  int topAltitudeMeters;
  int lastShiftId;
  int lastFlightLogId;

  HomeModel({
    this.topFlightTimeMinutes = 0,
    this.topDistanceMeters = 0,
    this.topAltitudeMeters = 0,
    this.lastShiftId = -1,
    this.lastFlightLogId = -1,
  });

  Map<String, int> toMap() {
    return {
      'topFlightTimeMinutes': topFlightTimeMinutes,
      'topDistanceMeters': topDistanceMeters,
      'topAltitudeMeters': topAltitudeMeters,
      'lastShiftId': lastShiftId,
      'lastFlightLogId': lastFlightLogId,
    };
  }
}

class CalculationResultModel {
  int shiftsCount;
  int flightsCount;
  int flightsAtDayCount;
  int flightsAtDayTotalMinutes;
  String flightsAtDayTotalTime;
  int flightsAtNightCount;
  int flightsAtNightTotalMinutes;
  String flightsAtNightTotalTime;
  int flightsTotalMinutes;
  String flightsTotalTime;
  String startingDate;
  String endingDate;
  String dayStartsAt;
  String dayEndsAt;
  int topFlightTimeMinutes;
  int topDistanceMeters;
  int topAltitudeMeters;
  int lastShiftId;
  int lastFlightLogId;

  CalculationResultModel({
    this.shiftsCount = 0,
    this.flightsCount = 0,
    this.flightsAtDayCount = 0,
    this.flightsAtDayTotalMinutes = 0,
    this.flightsAtDayTotalTime = '-',
    this.flightsAtNightCount = 0,
    this.flightsAtNightTotalMinutes = 0,
    this.flightsAtNightTotalTime = '-',
    this.flightsTotalMinutes = 0,
    this.flightsTotalTime = '-',
    this.startingDate = '-',
    this.endingDate = '-',
    this.dayStartsAt = '',
    this.dayEndsAt = '',
    this.topFlightTimeMinutes = 0,
    this.topDistanceMeters = 0,
    this.topAltitudeMeters = 0,
    this.lastShiftId = 0,
    this.lastFlightLogId = 0,
  });

  Map<String, Object> toMap() {
    return {
      'shiftsCount': shiftsCount,
      'flightsCount': flightsCount,
      'flightsAtDayCount': flightsAtDayCount,
      'flightsAtDayTotalMinutes': flightsAtDayTotalMinutes,
      'flightsAtDayTotalTime': flightsAtDayTotalTime,
      'flightsAtNightCount': flightsAtNightCount,
      'flightsAtNightTotalMinutes': flightsAtNightTotalMinutes,
      'flightsAtNightTotalTime': flightsAtNightTotalTime,
      'flightsTotalMinutes': flightsTotalMinutes,
      'flightsTotalTime': flightsTotalTime,
      'startingDate': startingDate,
      'endingDate': endingDate,
      'dayStartsAt': dayStartsAt,
      'dayEndsAt': dayEndsAt,
      'topFlightTimeMinutes': topFlightTimeMinutes,
      'topDistanceMeters': topDistanceMeters,
      'topAltitudeMeters': topAltitudeMeters,
      'lastShiftId': lastShiftId,
      'lastFlightLogId': lastFlightLogId,
    };
  }
}

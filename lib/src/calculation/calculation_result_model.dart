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
    };
  }
}

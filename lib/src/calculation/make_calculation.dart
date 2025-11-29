import '../db/queries.dart';
import '../flight_logs/flight_log_model.dart';
import '../utils/date_time/get_date_string_without_time.dart';
import '../utils/date_time/get_time.dart';
import '../utils/date_time/to_date_time.dart';
import '../utils/date_time/time_to_double.dart';
import 'flight_minutes_model.dart';
import 'get_flight_minutes.dart';
import 'calculation_result_model.dart';
import 'utils.dart';
import 'default_vars.dart';

///
///
///
Future<CalculationResultModel> getDataFromDbAndMakeCalculation({
  required DateTime fromDate,
  required DateTime toDate,
  required String dayStartsAt,
  required String dayEndsAt,
}) async {
  int shiftsCount = await getShiftsCountForPeriodFromDb(
    fromDate: fromDate,
    toDate: toDate,
  );

  List<FlightLogModel> logs = await getFlightLogsFromDb(
    fromDate: fromDate,
    toDate: toDate,
    limit: 9999,
  );

  String startingDate = getDateStringWithoutTimeFromDateTime(fromDate);
  String endingDate = getDateStringWithoutTimeFromDateTime(toDate);

  return makeCalculation(
    shiftsCount: shiftsCount,
    logs: logs,
    dayStart: dayStartsAt,
    dayEnd: dayEndsAt,
    startingDate: startingDate,
    endingDate: endingDate,
  );
}

///
///
///
CalculationResultModel makeCalculation({
  int shiftsCount = -1,
  List<FlightLogModel> logs = const [],
  String dayStart = '',
  String dayEnd = '',
  String startingDate = '',
  String endingDate = '',
}) {
  String dayStartsAt = dayStart.isEmpty ? dayStartOptions.first : dayStart;
  String dayEndsAt = dayEnd.isEmpty ? dayEndOptions.first : dayEnd;

  int flightsAtDayCount = 0;
  int flightsAtDayTotalMinutes = 0;
  int flightsAtNightCount = 0;
  int flightsAtNightTotalMinutes = 0;
  int flightsTotalMinutes = 0;

  List<FlightLogModel> flights = logs;

  List<FlightLogModel> unprocessedLogs = [];
  List<FlightLogModel> unresolvedLogsToSetAsDayOrNight = [];

  double dayStartDouble = timeToDouble(dayStartsAt);
  double dayEndDouble = timeToDouble(dayEndsAt);

  if (dayStartDouble == -1 || dayEndDouble == -1) {
    // RETURN UNPROCESSED RESULT
  }

  List<String> takeoffDateAndTimes = [];
  List<String> landingDateAndTimes = [];

  for (final flight in flights) {
    double flightStart = timeToDouble(getTime(flight.takeoffDateAndTime));
    double flightEnd = timeToDouble(getTime(flight.landingDateAndTime));

    takeoffDateAndTimes.add(flight.takeoffDateAndTime);
    landingDateAndTimes.add(flight.landingDateAndTime);

    if (flightStart == -1 || flightEnd == -1) {
      unprocessedLogs.add(flight);
      continue;
    }

    DateTime takeoff = toDateTime(flight.takeoffDateAndTime);
    DateTime landing = toDateTime(flight.landingDateAndTime);

    if (landing.difference(takeoff).inHours.abs() >= 24) {
      unprocessedLogs.add(flight);
      continue;
    }

    FlightMinutesModel minutes = getFlightMinutes(
      dayStart: dayStartDouble,
      dayEnd: dayEndDouble,
      flightStart: flightStart,
      flightEnd: flightEnd,
    );

    flightsTotalMinutes += flight.flightTimeMinutes;

    String flightCategory = resolveDayOrNightFlight(minutes);

    if (flightCategory == 'day') {
      flightsAtDayCount += 1;
      flightsAtDayTotalMinutes += flight.flightTimeMinutes;
    } else if (flightCategory == 'night'){
      flightsAtNightCount +=1;
      flightsAtNightTotalMinutes += flight.flightTimeMinutes;
    } else { // 'unresolved'
      unresolvedLogsToSetAsDayOrNight.add(flight);
    }
  }

  String flightsAtDayTotalTime = minutesToTimeString(
    flightsAtDayTotalMinutes,
  );
  String flightsAtNightTotalTime = minutesToTimeString(
    flightsAtNightTotalMinutes,
  );
  String flightsTotalTime = minutesToTimeString(flightsTotalMinutes);

  String startDate = startingDate;
  if (startDate.isEmpty) {
    DateTime? foundStartDate = findEarliestDate(takeoffDateAndTimes);
    startDate = foundStartDate != null
      ? getDateStringWithoutTimeFromDateTime(foundStartDate)
      : '';
  }

  String endDate = endingDate;
  if (endDate.isEmpty) {
    DateTime? foundEndDate = findLatestDate(landingDateAndTimes);
    endDate = foundEndDate != null
      ? getDateStringWithoutTimeFromDateTime(foundEndDate)
      : '';
  }

  return CalculationResultModel(
    shiftsCount: shiftsCount,
    flightsCount: flights.length,
    flightsAtDayCount: flightsAtDayCount,
    flightsAtDayTotalMinutes: flightsAtDayTotalMinutes,
    flightsAtDayTotalTime: flightsAtDayTotalTime,
    flightsAtNightCount: flightsAtNightCount,
    flightsAtNightTotalMinutes: flightsAtNightTotalMinutes,
    flightsAtNightTotalTime: flightsAtNightTotalTime,
    flightsTotalMinutes: flightsTotalMinutes,
    flightsTotalTime: flightsTotalTime,
    startingDate: startDate,
    endingDate: endDate,
    dayStartsAt: dayStartsAt,
    dayEndsAt: dayEndsAt,
  );
}

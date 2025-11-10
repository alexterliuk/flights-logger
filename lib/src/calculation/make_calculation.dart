import 'package:flights_logger/src/calculation/flight_minutes_model.dart';
import 'package:flights_logger/src/calculation/get_flight_minutes.dart';
import 'package:flutter/widgets.dart';

import '../db/queries.dart';
import '../flight_logs/flight_log_model.dart';
import '../utils/date_time/get_date_string_without_time.dart';
import '../utils/date_time/get_time.dart';
import '../utils/date_time/to_date_time.dart';
import '../utils/date_time/time_to_double.dart';
import 'calculate_data.dart';
import 'calculation_result_model.dart';
import 'utils.dart';

Future<CalculationResultModel> makeCalculation({
  required DateTime fromDate,
  required DateTime toDate,
  required String dayStartsAt,
  required String dayEndsAt,
}) async {
  // int shiftsTotalCount = await getShiftsTotalCountFromDb();
  // int flightsTotalCount = await getAxisDirectionFromAxisReverseAndDirectionality(context, axis, reverse)
  int shiftsCount = await getShiftsCountForPeriodFromDb(
    fromDate: fromDate,
    toDate: toDate,
  );

  int flightsAtDayCount = 0;
  int flightsAtDayTotalMinutes = 0;
  int flightsAtNightCount = 0;
  int flightsAtNightTotalMinutes = 0;
  int flightsTotalMinutes = 0;

  List<FlightLogModel> flights = await getFlightLogsFromDb(
    fromDate: fromDate,
    toDate: toDate,
    limit: 9999,
  );

  List<FlightLogModel> unprocessedLogs = [];
  List<FlightLogModel> unresolvedLogsToSetAsDayOrNight = [];

  double dayStart = timeToDouble(dayStartsAt);
  double dayEnd = timeToDouble(dayEndsAt);

  if (dayStart == -1 || dayEnd == -1) {
    // RETURN UNPROCESSED RESULT
  }

  for (final flight in flights) {
    double flightStart = timeToDouble(getTime(flight.takeoffDateAndTime));
    double flightEnd = timeToDouble(getTime(flight.landingDateAndTime));

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
      dayStart: dayStart,
      dayEnd: dayEnd,
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

    // String dateString =
    //   getDateStringWithoutTimeFromDateString(flight.takeoffDateAndTime);
    //
    // if (currentDateString != dateString) {
    //   currentDateString = dateString;
    // }

    // DateTime date = toDateTime(flight.takeoffDateAndTime);

    // 1. convert dayStartsAt to int dayStartsAtHour & int dayStartsAtMinute
    // 2. convert dayEndsAt to int dayEndsAtHour & int dayEndsAtMinute
    // 3. if ...
    // FlightLogModel(
    //   takeoffDateAndTime: takeoffDateAndTime,
    //   landingDateAndTime: landingDateAndTime,
    //   flightTimeMinutes: flightTimeMinutes,
    // );
  }

  String startingDate = getDateStringWithoutTimeFromDateTime(fromDate);
  String endingDate = getDateStringWithoutTimeFromDateTime(toDate);

  String flightsAtDayTotalTime = minutesToTimeString(
    flightsAtDayTotalMinutes,
  );
  String flightsAtNightTotalTime = minutesToTimeString(
    flightsAtNightTotalMinutes,
  );
  String flightsTotalTime = minutesToTimeString(flightsTotalMinutes);

  return Future.delayed(const Duration(milliseconds: 2300), () {
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
      startingDate: startingDate,
      endingDate: endingDate,
      dayStartsAt: dayStartsAt,
      dayEndsAt: dayEndsAt,
    );
  });
}

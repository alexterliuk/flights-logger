import '../home/home_model.dart';
import '../flight_logs/flight_log_model.dart';
import '../shifts/shift_model.dart';
import '../utils/date_time/is_first_date_and_time_earlier.dart';
import '../utils/date_time/is_first_date_and_time_later.dart';
import '../utils/extract_int.dart';

bool validateString(dynamic mayBeString) {
  return mayBeString is String;
}

bool validateInt(dynamic mayBeInt) {
  return mayBeInt is int;
}

bool validateDateAndTime(dynamic maybeDateAndTime) {
  var str = maybeDateAndTime;
  if (str is! String) {
    return false;
  }

  var year = str.substring(0, 4);
  var yearInt = extractInt(year);
  var isValidYear = yearInt > 1900 && yearInt < 2999;

  var month = str.substring(5, 7);
  var monthInt = extractInt(month);
  var isValidMonth = monthInt > 0 && monthInt < 13;

  var day = str.substring(8, 10);
  var dayInt = extractInt(day);
  var isValidDay = dayInt > 0 && dayInt < 32;

  var hours = str.substring(11, 13);
  var hoursInt = extractInt(hours);
  var isValidHours = hoursInt >= 0 && hoursInt < 24;

  var minutes = str.substring(14, 16);
  var minutesInt = extractInt(minutes);
  var isValidMinutes = minutesInt >= 0 && minutesInt < 60;

  return isValidYear
    && isValidMonth
    && isValidDay
    && isValidHours
    && isValidMinutes;
}

FlightLogModel convertToLog(dynamic decodedLog) {
  try {
    String droneName = validateString(decodedLog['droneName'])
      ? decodedLog['droneName']
      : throw();
    String droneId = validateString(decodedLog['droneId'])
      ? decodedLog['droneId']
      : throw();
    String takeoffDateAndTime =
      validateDateAndTime(decodedLog['takeoffDateAndTime'])
        ? decodedLog['takeoffDateAndTime']
        : throw();
    String landingDateAndTime =
      validateDateAndTime(decodedLog['landingDateAndTime'])
        ? decodedLog['landingDateAndTime']
        : throw();
    int flightTimeMinutes = validateInt(decodedLog['flightTimeMinutes'])
      ? decodedLog['flightTimeMinutes']
      : throw();
    int distanceMeters = validateInt(decodedLog['distanceMeters'])
      ? decodedLog['distanceMeters']
      : throw();
    int altitudeMeters = validateInt(decodedLog['altitudeMeters'])
      ? decodedLog['altitudeMeters']
      : throw();
    String location = validateString(decodedLog['location'])
      ? decodedLog['location']
      : throw();
    String droneAccum = validateString(decodedLog['droneAccum'])
      ? decodedLog['droneAccum']
      : throw();
    int droneAccumChargeLeft = validateInt(decodedLog['droneAccumChargeLeft'])
      ? decodedLog['droneAccumChargeLeft']
      : throw();
    int rcAccumChargeLeft = validateInt(decodedLog['rcAccumChargeLeft'])
      ? decodedLog['rcAccumChargeLeft']
      : throw();
    String note = validateString(decodedLog['note'])
      ? decodedLog['note']
      : throw();
    int shiftId = validateInt(decodedLog['shiftId'])
      ? decodedLog['shiftId']
      : throw();
    int id = validateInt(decodedLog['id'])
      ? decodedLog['id']
      : throw();

    return FlightLogModel(
      droneName: droneName,
      droneId: droneId,
      takeoffDateAndTime: takeoffDateAndTime,
      landingDateAndTime: landingDateAndTime,
      flightTimeMinutes: flightTimeMinutes,
      distanceMeters: distanceMeters,
      altitudeMeters: altitudeMeters,
      location: location,
      droneAccum: droneAccum,
      droneAccumChargeLeft: droneAccumChargeLeft,
      rcAccumChargeLeft: rcAccumChargeLeft,
      note: note,
      shiftId: shiftId,
      id: id,
    );
  } catch(err) {
    throw();
  }
}

List<FlightLogModel> convertToLogs(List<dynamic> decodedLogs) {
  List<FlightLogModel> logs = [];

  try {
    for (final dLog in decodedLogs) {
      FlightLogModel log = convertToLog(dLog);
      logs.add(log);
    }

    return logs;
  } catch (err) {
    print('''[convertToLogs] ERR
    last processed log's id - ${logs.lastOrNull?.id}
    logs count - ${logs.length}
    ''');

    return [];
  }
}

class ShiftsAndHome {
  List<ShiftModel> shifts;
  HomeModel home;

  ShiftsAndHome({
    required this.shifts,
    required this.home,
  });
}

ShiftsAndHome createShiftsAndHome(List<FlightLogModel> logs) {
  List<ShiftModel> shifts = [];
  HomeModel home = HomeModel();
  Map<int, ShiftModel> shiftsMap = {};

  try {
    for (final log in logs) {
      if (!shiftsMap.containsKey(log.shiftId)) {
        var sh = shiftsMap.putIfAbsent(log.shiftId, () => ShiftModel(id: log.shiftId));
        shifts.add(sh);
        sh.logIds = [...sh.logIds, log.id];
        sh.startedAtDateAndTime = log.takeoffDateAndTime;
        sh.endedAtDateAndTime = log.landingDateAndTime;
        sh.flightsQty += 1;
        sh.timeTotalMinutes = log.flightTimeMinutes;
        sh.longestFlightTimeMinutes = log.flightTimeMinutes;
        sh.longestDistanceMeters = log.distanceMeters;
        sh.highestAltitudeMeters = log.altitudeMeters;
      } else {
        var sh = shiftsMap[log.shiftId] as ShiftModel;
        updateShiftIfNeeded(sh, log);
        shiftsMap.update(log.shiftId, (bSh) => bSh);
      }
      updateHomeIfNeeded(home, log);
      updateLastLogAndShiftId(home, log, logs);
    }
  } catch (err) {
    print('''[createShifts] ERR
    $err
    ''');
  }

  return ShiftsAndHome(shifts: shifts, home: home);
}

void updateShiftIfNeeded(ShiftModel sh, FlightLogModel log) {
  if (!sh.logIds.contains(log.id)) {
    sh.logIds.add(log.id);
  }

  var hasLogStartedEarlier = isFirstDateAndTimeEarlier(
    log.takeoffDateAndTime,
    sh.startedAtDateAndTime,
  );
  if (hasLogStartedEarlier) {
    sh.startedAtDateAndTime = log.takeoffDateAndTime;
  }

  var hasLogEndedLater = isFirstDateAndTimeLater(
    log.landingDateAndTime,
    sh.endedAtDateAndTime,
  );
  if (hasLogEndedLater) {
    sh.endedAtDateAndTime = log.landingDateAndTime;
  }

  sh.flightsQty += 1;
  sh.timeTotalMinutes += log.flightTimeMinutes;

  if (log.flightTimeMinutes > sh.longestFlightTimeMinutes) {
    sh.longestFlightTimeMinutes = log.flightTimeMinutes;
  }

  if (log.distanceMeters > sh.longestDistanceMeters) {
    sh.longestDistanceMeters = log.distanceMeters;
  }

  if (log.altitudeMeters > sh.highestAltitudeMeters) {
    sh.highestAltitudeMeters = log.altitudeMeters;
  }
}

void updateHomeIfNeeded(HomeModel home, FlightLogModel log) {
  if (log.flightTimeMinutes > home.topFlightTimeMinutes) {
    home.topFlightTimeMinutes = log.flightTimeMinutes;
  }

  if (log.distanceMeters > home.topDistanceMeters) {
    home.topDistanceMeters = log.distanceMeters;
  }

  if (log.altitudeMeters > home.topAltitudeMeters) {
    home.topAltitudeMeters = log.altitudeMeters;
  }
}

void updateLastLogAndShiftId(
  HomeModel home,
  FlightLogModel log,
  List<FlightLogModel> logs,
) {
  if (home.lastFlightLogId == -1) {
    home.lastFlightLogId = log.id;
    home.lastShiftId = log.shiftId;
  } else {
    var lastLogLanding = logs.firstWhere(
      (l) => l.id == home.lastFlightLogId
    ).landingDateAndTime;

    if (isFirstDateAndTimeLater(log.landingDateAndTime, lastLogLanding)) {
      home.lastFlightLogId = log.id;
      home.lastShiftId = log.shiftId;
    }
  }
}

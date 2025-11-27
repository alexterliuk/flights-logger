import '../flight_logs/flight_log_model.dart';
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

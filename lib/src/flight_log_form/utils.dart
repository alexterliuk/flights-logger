import '../utils/date_time/parse_date_and_time.dart';

import '../flight_logs/flight_log_model.dart';
import '../utils/extract_int.dart';

String? validateHours(String? hoursStr) {
  int hours = extractInt(hoursStr ?? '');

  if (hours < 0 || hours > 23) {
    return ''; // NB: there were ' ' and seemed that it worked ok
  }

  return null;
}

String? validateMinutes(String? minutesStr) {
  int minutes = extractInt(minutesStr ?? '');

  if (minutes < 0 || minutes > 59) {
    return '';
  }

  return null;
}

String? validateFlightTime(String? minutesStr) {
  int minutes = extractInt(minutesStr ?? '');

  if (minutes < 1) {
    return '';
  }

  return null;
}

String? validateDistance(String? metersStr) {
  int meters = extractInt(metersStr ?? '');

  if (meters <= 0) {
    return '';
  }

  return null;
}

String? validateAltitude(String? metersStr) {
  int meters = extractInt(metersStr ?? '');

  if (meters <= 0) {
    return '';
  }

  return null;
}

String? validateLocation(String? location) {
  if (location == null || location.isEmpty) {
    return '';
  }

  return null;
}

bool hasFlightLogChanged(FlightLogModel originalLog, BaseFlightLogModel editedLog) {
  List<bool> changes = [
    originalLog.takeoffDateAndTime != editedLog.takeoffDateAndTime,
    originalLog.landingDateAndTime != editedLog.landingDateAndTime,
    originalLog.flightTimeMinutes != editedLog.flightTimeMinutes,
    originalLog.distanceMeters != editedLog.distanceMeters,
    originalLog.altitudeMeters != editedLog.altitudeMeters,
    originalLog.location != editedLog.location,
    originalLog.droneAccum != editedLog.droneAccum,
    originalLog.droneAccumChargeLeft != editedLog.droneAccumChargeLeft,
    originalLog.rcAccumChargeLeft != editedLog.rcAccumChargeLeft,
  ];

  return changes.any((change) => change == true);
}

String getDateCaption(DateTime dateTime) {
  String month = prependZeroIfNeeded('${dateTime.month}');

  return '${dateTime.day}.$month.${dateTime.year}';
}

String getDateCaptionFromDateAndTime(String dateAndTime) { // '2024-07-20 23:48'
  ParsedDateAndTime parsedDT = parseDateAndTime(dateAndTime);
  final month = prependZeroIfNeeded('${parsedDT.month}');

  return '${parsedDT.day}.$month.${parsedDT.year}';
}

String getISODateStringWithoutTime(String dateString) { // '17.07.2024'
  List<String> segments = dateString.split('.');
  final year = segments[2];
  final month = segments[1];
  final day = prependZeroIfNeeded(segments.first);

  return '$year-$month-$day';
}

String prependZeroIfNeeded(String numStr) {
  return numStr.length == 1 ? '0$numStr' : numStr;
}

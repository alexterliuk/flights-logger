import 'package:flights_logger/src/flight_log_form/utils.dart';
import 'package:flights_logger/src/utils/date_time/to_date_time.dart';

import './calc_landing_time.dart';
import '../../extract_int.dart';

class GetLandingTimeArgument {
  GetLandingTimeArgument(this.text, this.validate);

  final String text;
  final String? Function(String? value) validate;
}

LandingTime getLandingTime (
  String dateISO,
  GetLandingTimeArgument takeoffHours,
  GetLandingTimeArgument takeoffMinutes,
  GetLandingTimeArgument flightTime,
) {
  final invalidLandingTime = LandingTime('', DateTime.now(), true);

  if (
    takeoffHours.text.isNotEmpty &&
    takeoffMinutes.text.isNotEmpty &&
    flightTime.text.isNotEmpty
  ) {
    if (
      takeoffHours.validate(takeoffHours.text) != '' &&
      takeoffMinutes.validate(takeoffMinutes.text) != '' &&
      flightTime.validate(flightTime.text) != ''
    ) {
      var takeoffH = prependZeroIfNeeded(takeoffHours.text);
      var takeoffM = prependZeroIfNeeded(takeoffMinutes.text);

      final takeoffDateAndTime = '$dateISO $takeoffH:$takeoffM';
      final takeoffDateTime = toDateTime(takeoffDateAndTime);
      final flightTimeMinutesInt = extractInt(flightTime.text);

      final LandingTime landingTime = calcLandingTime(takeoffDateTime, flightTimeMinutesInt);

      print('landingTime: ${landingTime.dateTime.toIso8601String()}');
      return landingTime;
    }

    return invalidLandingTime;
  }

  return invalidLandingTime;
}

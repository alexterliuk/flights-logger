import 'flight_minutes_model.dart';
import 'utils.dart';

///
///
///
int extractMinutes(double num) {
  if (num.toString().contains('.')) {
    if (num.floor() >= 10) {
      String minutes = num.toString().padRight(5, '0').substring(3);
      return int.parse(minutes);
    } else {
      String minutes = num.toString().padRight(4, '0').substring(2);
      return int.parse(minutes);
    }
  }

  return 0;
}

///
/// returns int day or night
///
int getMinutesOnePeriod(
  int hours,
  int flightStartMinutes,
  int flightEndMinutes,
) {
  int minutes = hours * 60;

  return flightStartMinutes <= flightEndMinutes
    ? minutes + (flightEndMinutes - flightStartMinutes)
    : minutes - (flightStartMinutes - flightEndMinutes);
}

///
///
///
FlightMinutesModel getMinutesTwoPeriods(
  double flightStart,
  double dayStart,
  double dayEnd,
  int hoursDay,
  int hoursNight,
  int flightStartMinutes,
  int flightEndMinutes,
  {
    bool isFlightEndBeforeEvening = false,
    bool isFlightAboutTheWholeDay = false,
    bool isFlightEndBeforeMidnight = false,
    bool isFlightEndBeforeMorning = false,
    bool isFlightEndInTheDay = false,
  }
) {
  int minutesDay = 0;
  int minutesNight = 0;

  if (flightStart >= dayEnd) { // ------------------- (A)
    if (flightStartMinutes < flightEndMinutes) {
      if (isFlightEndBeforeEvening) {
        // e.g. 21.19-11.44
        minutesDay = hoursDay * 60 + flightEndMinutes;
        minutesNight = hoursNight * 60 - flightStartMinutes;
      } else if (isFlightAboutTheWholeDay) {
        // e.g. 21.19-20.44
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60 - flightStartMinutes + flightEndMinutes;
      }
    } else if (flightStartMinutes > flightEndMinutes) {
      if (isFlightEndBeforeEvening) {
        // e.g. 21.44-11.19
        minutesDay = hoursDay * 60 + flightEndMinutes;
        minutesNight = hoursNight * 60 - flightStartMinutes;
      } else if (isFlightAboutTheWholeDay) {
        // e.g. 21.44-20.19
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60 + flightEndMinutes - flightStartMinutes;
      }
    } else { // flightStartMinutes == flightEndMinutes
      if (isFlightEndBeforeEvening) {
        // e.g. 21.19-11.19
        minutesDay = hoursDay * 60 + flightEndMinutes;
        minutesNight = hoursNight * 60 - flightStartMinutes;
      } else if (isFlightAboutTheWholeDay) {
        // e.g. 21.44-20.44
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60;
      }
    }

  } else if (flightStart < dayStart) { // ------------------- (B)
    if (flightStartMinutes < flightEndMinutes) {
      if (isFlightAboutTheWholeDay) {
        // e.g. 3.19-2.44
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60 + flightEndMinutes - flightStartMinutes;
      } else if (isFlightEndBeforeEvening) {
        // e.g. 3.19-16.44
        minutesDay = hoursDay * 60 + flightEndMinutes;
        minutesNight = hoursNight * 60 - flightStartMinutes;
      } else if (isFlightEndBeforeMidnight) {
        // e.g. 3.19-23.44
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60 + flightEndMinutes - flightStartMinutes;
      }
    } else if (flightStartMinutes > flightEndMinutes) {
      if (isFlightAboutTheWholeDay) {
        // e.g. 3.44-2.19
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60 + flightEndMinutes - flightStartMinutes;
      } else if (isFlightEndBeforeEvening) {
        // e.g. 3.44-16.19
        minutesDay = hoursDay * 60 + flightEndMinutes;
        minutesNight = hoursNight * 60 - flightStartMinutes;
      } else if (isFlightEndBeforeMidnight) {
        // e.g. 3.44-23.19
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60 + flightEndMinutes - flightStartMinutes;
      }
    } else { // flightStartMinutes == flightEndMinutes
      if (isFlightAboutTheWholeDay) {
        // e.g. 3.19-2.19
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60;
      } else if (isFlightEndBeforeEvening) {
        // e.g. 3.44-16.44
        minutesDay = hoursDay * 60 + flightEndMinutes;
        minutesNight = hoursNight * 60 - flightStartMinutes;
      } else if (isFlightEndBeforeMidnight) {
        // e.g. 3.19-23.19
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60;
      }
    }

  } else if (flightStart < dayEnd) { // ------------------- (C)
    if (flightStartMinutes < flightEndMinutes) {
      if (isFlightEndBeforeMidnight) {
        // e.g. 4.19-23.44
        minutesDay = hoursDay * 60 - flightStartMinutes;
        minutesNight = hoursNight * 60 + flightEndMinutes;
      } else if (isFlightEndBeforeMorning) {
        // e.g. 4.19-3.44
        minutesDay = hoursDay * 60 - flightStartMinutes;
        minutesNight = hoursNight * 60 + flightEndMinutes;
      } else if (isFlightEndInTheDay) {
        // e.g. 6.19-4.44
        minutesDay = hoursDay * 60 + flightEndMinutes - flightStartMinutes;
        minutesNight = hoursNight * 60;
      }
    } else if (flightStartMinutes > flightEndMinutes) {
      if (isFlightEndBeforeMidnight) {
        // e.g. 4.44-23.19
        minutesDay = hoursDay * 60 - flightStartMinutes;
        minutesNight = hoursNight * 60 + flightEndMinutes;
      } else if (isFlightEndBeforeMorning) {
        // e.g. 4.44-3.19
        minutesDay = hoursDay * 60 - flightStartMinutes;
        minutesNight = hoursNight * 60 + flightEndMinutes;
      } else if (isFlightEndInTheDay) {
        // e.g. 6.44-4.19
        minutesDay = hoursDay * 60 + flightEndMinutes - flightStartMinutes;
        minutesNight = hoursNight * 60;
      }
    } else { // flightStartMinutes == flightEndMinutes
      if (isFlightEndBeforeMidnight) {
        // e.g. 4.19-23.19
        minutesDay = hoursDay * 60 - flightStartMinutes;
        minutesNight = hoursNight * 60 + flightEndMinutes;
      } else if (isFlightEndBeforeMorning) {
        // e.g. 4.19-3.19
        minutesDay = hoursDay * 60 - flightStartMinutes;
        minutesNight = hoursNight * 60 + flightEndMinutes;
      } else if (isFlightEndInTheDay) {
        // e.g. 6.44-4.44
        minutesDay = hoursDay * 60;
        minutesNight = hoursNight * 60;
      }
    }
  }

  return FlightMinutesModel(atDay: minutesDay, atNight: minutesNight);
}

///
///
///
FlightMinutesModel getFlightMinutes({
  required double dayStart,
  required double dayEnd,
  required double flightStart,
  required double flightEnd,
}) {
  int hoursDay = 0;
  int hoursNight = 0;
  int flightStartMinutes = 0;
  int flightEndMinutes = 0;
  int minutesDay = 0;
  int minutesNight = 0;

  flightStartMinutes = extractMinutes(flightStart);
  flightEndMinutes = extractMinutes(flightEnd);

  /// A.
  if (flightStart >= dayEnd) { // from dayEnd to 23:59
    bool isFlightEndBeforeMidnight = flightEnd > flightStart &&
        flightEnd <= 23.59;
    bool isFlightEndBeforeMorning = flightEnd < flightStart &&
        flightEnd <= dayStart;
    bool isFlightEndBeforeEvening = flightEnd < flightStart &&
        flightEnd <= dayEnd;
    bool isFlightAboutTheWholeDay = flightEnd < flightStart &&
        flightEnd >= dayEnd;

    if (isFlightEndBeforeMidnight) {
      // print('a');
      hoursNight = flightEnd.floor() - flightStart.floor();
      minutesNight = getMinutesOnePeriod(hoursNight, flightStartMinutes, flightEndMinutes);
    } else if (isFlightEndBeforeMorning) {
      // print('b');
      hoursNight = 24 - flightStart.floor() + flightEnd.floor();
      minutesNight = getMinutesOnePeriod(hoursNight, flightStartMinutes, flightEndMinutes);
    } else if (isFlightEndBeforeEvening) {
      /// starts from dayEnd to 23:59
      /// ends from dayStart to dayEnd
      // print('c');
      hoursDay = flightEnd.floor() - dayStart.floor();
      hoursNight = 24 - flightStart.floor() + dayStart.floor();

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightEndBeforeEvening: isFlightEndBeforeEvening,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    } else if (isFlightAboutTheWholeDay) {
      // print('d');
      hoursDay = dayEnd.floor() - dayStart.floor();
      hoursNight = 24 - flightStart.floor() + dayStart.floor() + (flightEnd.floor() - dayEnd.floor());

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightAboutTheWholeDay: isFlightAboutTheWholeDay,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    }
  /// B.
  } else if (flightStart < dayStart) { // from 0 to dayStart
    bool isFlightEndBeforeMorningAFewHours = flightEnd > flightStart &&
        flightEnd <= dayStart;
    bool isFlightAboutTheWholeDay = flightEnd < flightStart &&
        flightEnd < dayStart;
    bool isFlightEndBeforeEvening = flightEnd > dayStart && flightEnd <= dayEnd;
    bool isFlightEndBeforeMidnight = flightEnd > dayEnd && flightEnd <= 23.59;

    if (isFlightEndBeforeMorningAFewHours) {
      // print('e');
      hoursNight = flightEnd.floor() - flightStart.floor();
      minutesNight = getMinutesOnePeriod(hoursNight, flightStartMinutes, flightEndMinutes);
    } else if (isFlightAboutTheWholeDay) {
      // print('f');
      hoursDay = dayEnd.floor() - dayStart.floor();
      hoursNight = dayStart.floor() - flightStart.floor() + (24 - dayEnd.floor()) + flightEnd.floor();

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightAboutTheWholeDay: isFlightAboutTheWholeDay,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    } else if (isFlightEndBeforeEvening) {
      // print('g');
      hoursDay = flightEnd.floor() - dayStart.floor();
      hoursNight = dayStart.floor() - flightStart.floor();

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightEndBeforeEvening: isFlightEndBeforeEvening,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    } else if (isFlightEndBeforeMidnight) {
      // print('h');
      hoursDay = dayEnd.floor() - dayStart.floor();
      hoursNight = dayStart.floor() - flightStart.floor() + (flightEnd.floor() - dayEnd.floor());

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightEndBeforeMidnight: isFlightEndBeforeMidnight,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    }
  /// C.
  } else if (flightStart < dayEnd) { // from dayStart to dayEnd
    bool isFlightEndBeforeEvening = flightEnd >
        flightStart /*&& flightEnd > dayStart*/ && flightEnd <= dayEnd;
    bool isFlightEndBeforeMidnight =
        flightEnd > flightStart && flightEnd > dayEnd && flightEnd <= 23.59;
    bool isFlightEndBeforeMorning = flightEnd <
        dayStart /*&& flightEnd < flightStart*/;
    bool isFlightEndInTheDay = flightEnd >= dayStart && flightEnd < flightStart;

    if (isFlightEndBeforeEvening) {
      // print('i');
      hoursDay = flightEnd.floor() - flightStart.floor();
      minutesDay = getMinutesOnePeriod(hoursDay, flightStartMinutes, flightEndMinutes);
    } else if (isFlightEndBeforeMidnight) {
      // print('j');
      hoursDay = dayEnd.floor() - flightStart.floor();
      hoursNight = flightEnd.floor() - dayEnd.floor();

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightEndBeforeMidnight: isFlightEndBeforeMidnight,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    } else if (isFlightEndBeforeMorning) {
      // print('k');
      hoursDay = dayEnd.floor() - flightStart.floor();
      hoursNight = 24 - dayEnd.floor() + flightEnd.floor();

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightEndBeforeMorning: isFlightEndBeforeMorning,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    } else if (isFlightEndInTheDay) {
      // print('l');
      hoursDay = dayEnd.floor() - flightStart.floor() + (flightEnd.floor() - dayStart.floor());
      hoursNight = 24 - dayEnd.floor() + dayStart.floor();

      FlightMinutesModel minutes = getMinutesTwoPeriods(
        flightStart,
        dayStart,
        dayEnd,
        hoursDay,
        hoursNight,
        flightStartMinutes,
        flightEndMinutes,
        isFlightEndInTheDay: isFlightEndInTheDay,
      );

      minutesDay = minutes.atDay;
      minutesNight = minutes.atNight;
    }
  }

  return FlightMinutesModel(atDay: minutesDay, atNight: minutesNight);
}

import 'extract_int.dart';

// @returns index where to get an item with last date and time
int getLastDateAndTimeIndex(List<String> dateAndTimes) {
  int lastYear = -1;
  int lastMonth = -1;
  int lastDay = -1;
  int lastHour = -1;
  int lastMinute = -1;

  int lastIndex = 0;

  for (int i = 0; i < dateAndTimes.length; i++) {
    int currYear = getYear(dateAndTimes[i]);
    int currMonth = getMonth(dateAndTimes[i]);
    int currDay = getDay(dateAndTimes[i]);
    int currHour = getHour(dateAndTimes[i]);
    int currMinute = getMinute(dateAndTimes[i]);

    if (currYear > lastYear) {
      lastYear = currYear;
      lastMonth = currMonth;
      lastDay = currDay;
      lastHour = currHour;
      lastMinute = currMinute;

      lastIndex = i;

      continue;
    }

    if (currYear < lastYear) {
      continue;
    }

    // currYear == lastYear, so compare months
    if (currMonth > lastMonth) {
      lastMonth = currMonth;
      lastDay = currDay;
      lastHour = currHour;
      lastMinute = currMinute;

      lastIndex = i;

      continue;
    }

    if (currMonth < lastMonth) {
      continue;
    }

    // currMonth == lastMonth, so compare days
    if (currDay > lastDay) {
      lastDay = currDay;
      lastHour = currHour;
      lastMinute = currMinute;

      lastIndex = i;

      continue;
    }

    if (currDay < lastDay) {
      continue;
    }

    // currDay == lastDay, so compare hours
    if (currHour > lastHour) {
      lastHour = currHour;
      lastMinute = currMinute;

      lastIndex = i;

      continue;
    }

    if (currHour < lastHour) {
      continue;
    }

    // currHour == lastHour, so compare minutes
    if (currMinute > lastMinute) {
      currMinute = lastMinute;

      lastIndex = i;

      continue;
    }

    if (currMinute < lastMinute) {
      continue;
    }
  }

  return lastIndex;
}

int getYear(String dateAndTime) => extractInt(dateAndTime.substring(0, 4));
int getMonth(String dateAndTime) => extractInt(dateAndTime.substring(5, 7));
int getDay(String dateAndTime) => extractInt(dateAndTime.substring(8, 10));
int getHour(String dateAndTime) => extractInt(dateAndTime.substring(11, 13));
int getMinute(String dateAndTime) => extractInt(dateAndTime.substring(14));

// List<String> dnt = [
//   '2024-07-11 08:34',
//   '2024-07-11 08:57',
//   '2024-07-10 06:11',
//   '2024-07-09 03:04',
//   '2024-07-19 23:17',
//   '2025-02-10 20:05',
//   '2025-05-01 17:31',
//   '2021-05-01 10:19',
// ];
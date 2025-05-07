const monthNamesEn = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

const monthNamesUa = {
  1: 'січня',
  2: 'лютого',
  3: 'березня',
  4: 'квітня',
  5: 'травня',
  6: 'червня',
  7: 'липня',
  8: 'серпня',
  9: 'вересня',
  10: 'жовтня',
  11: 'листопада',
  12: 'грудня',
};

enum Language {
  en,
  ua,
}

/// monthNum - from 1 to 12
String getMonthReadable (
  int monthNum,
  Language lang,
  { bool fullMonthName = false }
) {
  final monthNames = lang == Language.en ? monthNamesEn : monthNamesUa;
  final foundName = monthNames[monthNum] ?? '';

  final monthName = fullMonthName ? foundName : foundName.substring(0, 3);

  return monthName.isNotEmpty ? monthName : '$monthNum';
}

// final q = getDateReadable(2, Language.en);

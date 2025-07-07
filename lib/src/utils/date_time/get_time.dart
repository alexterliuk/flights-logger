/// dateAndTime - 'YYYY-MM-DD HH:mm'
String getTime (String dateAndTime) {
  try {
    String time = dateAndTime.substring(11, 16);
    return time;
  } catch (e) {
    return '-';
  }
}

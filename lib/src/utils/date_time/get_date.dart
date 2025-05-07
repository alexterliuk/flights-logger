/// dateAndTime - 'YYYY-MM-DD HH:mm'
String getDate (String dateAndTime) {
  try {
    String date = dateAndTime.substring(0, 10);
    return date;
  } catch (e) {
    return '';
  }
}

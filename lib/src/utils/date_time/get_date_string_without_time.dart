String getDateStringWithoutTimeFromDateTime(DateTime dateTime) {
  return dateTime.toString().substring(0, 10);
}

String getDateStringWithoutTimeFromDateString(String dateString) {
  return dateString.substring(0, 10);
}

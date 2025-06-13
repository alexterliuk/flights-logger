String fromDateTime(DateTime dateTime) { // returns dateAndTime, e.g. '2024-07-20 23:48'
  return dateTime.toString().substring(0, 16);
}

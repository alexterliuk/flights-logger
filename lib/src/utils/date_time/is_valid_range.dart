bool isValidRange(DateTime fromDate, DateTime toDate) {
  try {
    if (fromDate.difference(toDate).inDays <= 0) {
      // 'from' is earlier than 'to' by a day or more, or equal if 0
      return true;
    } else {
      // 'from' is later than 'to' which is invalid
      return false;
    }
  } catch (e) {
    return false;
  }
}
